import 'dart:convert';
import 'package:http/http.dart' as http;

import '/LOGIN/login_page.dart';
import '/MODELS/ad_response.dart';
import '/MODELS/article_response.dart';
import '/MODELS/blog_response.dart';
import '/MODELS/inbox_response.dart';
import '/MODELS/login_response.dart';
import '/NETWORK/base_client.dart';
import '/UTILS/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../HOME/home_page.dart';
import '../MODELS/user_response.dart';
import '../NETWORK/app_exceptions.dart';
import '../NETWORK/network_string.dart';
import '../UTILS/consts.dart';
import '../UTILS/dialog_helper.dart';

class UserController extends GetxController {
  var uploadImageUrl = ''.obs;
  var uploadImage = Uint8List(0).obs;
  var userData = <UserData>[].obs;
  var blogData = <BlogData>[].obs;
  var adsData = <AdData>[].obs;
  var inboxData = <InboxData>[].obs;
  var articleData = <ArticleData>[].obs;
  var isPasswordVisible = true.obs;
  var isArticleView = true.obs;
  var selectedInboxData = InboxData().obs;

  var selectStartDate = 'Start Date'.obs;
  var selectEndDate = 'End Date'.obs;
  DateTime selectedDate = DateTime.now();

  @override
  void onReady() async {
    String? authKey = await Utility.getStringValue(authTokenKey);
    // if ((authKey ?? '').isNotEmpty) {
    //   Get.offAll(() => HomePage());
    // }
    print("authKey======================$authKey");

    super.onReady();
  }

  Future<void> selectDate(BuildContext context, int type) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2001),
        firstDate: DateTime(1960),
        lastDate: DateTime(2004));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      final DateFormat format = DateFormat('yyyy-MM-dd');
      final String formatted = format.format(selectedDate);
      type == 1
          ? selectStartDate.value = formatted
          : selectEndDate.value = formatted;
    }
  }

  Future<void> adminLogin(dynamic data) async {
    DialogHelper.showLoading();
    var response = BaseClient().post(adminLoginApi, data)?.catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });

    if (response == null) return;
    var sp = LoginResponse.fromJson(jsonDecode(await response));
    if (sp.status ?? false) {
      Utility.setStringValue(authTokenKey, sp.token ?? '');
      showSnackBar(sp.message ?? '', Colors.deepOrangeAccent);
      Get.offAll(() => HomePage());
    } else {
      showSnackBar(sp.message ?? '', Colors.deepOrangeAccent);
    }
    DialogHelper.hideLoading();
  }

  Future<void> forgotPassword(String email) async {
    DialogHelper.showLoading();

    dynamic data = {
      "email": email,
    };
    var response = await BaseClient().post(forgotPasswordApi, data);
    if (response == null) return;
    var res = jsonDecode(await response);
    DialogHelper.hideLoading();

    showSnackBar(res['message'] ?? '', Colors.green);
  }

  Future<void> getUserData(dynamic data) async {
    DialogHelper.showLoading();
    if (data["page"] == 1) {
      userData.clear();
    }
    var response =
        await BaseClient().post(getUserApi, data)?.catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    DialogHelper.hideLoading();
    if (response == null) return;
    var sp = UserResponse.fromJson(jsonDecode(await response));
    userData.addAll(sp.data ?? []);
  }

  Future<void> logoutUser() async {
    Utility().clearAll();
    Get.offAll(() => LoginPage(), transition: Transition.leftToRight);
  }

  Future<void> updateUserStatus(dynamic data) async {
    DialogHelper.showLoading();
    var response = await BaseClient().post(updateUserStatusApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);

    showSnackBar(res['message'], Colors.green);
  }

  Future<void> addArticleOrBlog(dynamic data, bool article, isUpdate) async {
    DialogHelper.showLoading();
    var response = await BaseClient().post(
        article
            ? isUpdate
                ? updateArticleApi
                : addArticleApi
            : isUpdate
                ? updateBlogApi
                : addBlogApi,
        data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    var dataPa = {
      "page": 1,
      "limit": 20,
      "sortBy": "desc",
      "sortOn": "created_at",
    };
    getIsArticles(dataPa, article);
    showSnackBar(res['message'], Colors.green);
  }

  Future<void> getIsArticles(dynamic data, bool article) async {
    DialogHelper.showLoading();
    if(data["page"]==1){
      if (article) {
        articleData.clear();
      }else {
        blogData.clear();
      }
    }
    var articleOrBlogRes = await BaseClient()
        .post(article ? getArticleApi : getBlogApi, data)
        ?.catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    DialogHelper.hideLoading();
    if (articleOrBlogRes == null) return;
    if (article) {
      var sp = ArticleResponse.fromJson(jsonDecode(await articleOrBlogRes));
      articleData.value = sp.data ?? [];
    } else {
      var sp = BlogResponse.fromJson(jsonDecode(await articleOrBlogRes));
      blogData.value = sp.data ?? [];
    }
  }

  void deleteArticle(Map<String, String> data, bool article) async {
    DialogHelper.showLoading();
    var response = await BaseClient()
        .post(article ? deleteArticleApi : deleteBlogApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    var dataPa = {
      "page":1,
      "limit": 20,
      "sortBy": "desc",
      "sortOn": "created_at",
    };
    getIsArticles(dataPa, article);
    showSnackBar(res['message'], Colors.green);
  }

  getAdsData(dynamic data) async {
    if(data['page']==1){
      inboxData.clear();
    }
    DialogHelper.showLoading();
    var response =
        await BaseClient().post(getAdsApi, data)?.catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    DialogHelper.hideLoading();
    if (response == null) return;
    print(response);
    var sp = AdsResponse.fromJson(jsonDecode(await response));
    adsData.value = sp.data ?? [];
  }

  getInboxData(dynamic data) async {
    DialogHelper.showLoading();
    if(data['page']==1){
      inboxData.clear();
    }
    var response =
        await BaseClient().post(getInboxApi, data)?.catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    DialogHelper.hideLoading();
    if (response == null) return;
    print(response);
    var sp = InboxResponse.fromJson(jsonDecode(await response));
    inboxData.value = sp.data ?? [];
  }

  void updateInbox(dynamic data) async {
    DialogHelper.showLoading();
    var response = await BaseClient().post(updateInboxApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    showSnackBar(res['message'], Colors.green);

    var dataPa = {
      "page": 1,
      "limit": 20,
      "sortBy": "desc",
      "sortOn": "created_at",
    };
    getInboxData(dataPa);
  }

  Future<void> addAd(dynamic data, isUpdate) async {
    DialogHelper.showLoading();
    var response =
        await BaseClient().post(isUpdate ? updateAdsApi : addAdsApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    var dataPa = {"page": "1", "limit": "20"};
    getAdsData(dataPa);
    showSnackBar(res['message'], Colors.green);
  }

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((xFile) async {
      uploadImage.value = await xFile!.readAsBytes();
      DialogHelper.showLoading();
      var request = http.MultipartRequest(
          'POST', Uri.parse(BaseClient.baseUrl + uploadImageApi));
      request.headers.addAll({
        "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
        "Authorization": "",
        "Content-Type": "application/json",
      });
      request.files.add(http.MultipartFile.fromBytes(
          'image',
          await xFile.readAsBytes().then((value) {
            return value.cast();
          }),filename: xFile.path.toString() + xFile.name));
      request.fields['type'] = "fish";

      return await request.send().then((value) {
        if (value.statusCode == 200) {
          DialogHelper.hideLoading();
          value.stream.transform(utf8.decoder).listen((value) {
            var apiRes = json.decode(value);
            //print("postImageUpload===========${apiRes['data']}");
            uploadImageUrl.value = apiRes['data'];
          });
          return uploadImageUrl.value;
        } else {
          return uploadImageUrl.value;
        }
      });
    });
  }

  deleteAds(dynamic data) async {
    DialogHelper.showLoading();
    var response = await BaseClient().post(deleteAdsApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    var dataPa = {
      "page": 1,
      "limit": 20,
      "sortBy": "desc",
      "sortOn": "created_at",
    };
    getAdsData(dataPa);
    showSnackBar(res['message'], Colors.green);
  }
}
