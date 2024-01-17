import 'dart:convert';

import '/MODELS/category_response.dart';
import '/MODELS/faq_response.dart';
import '/MODELS/fish_response.dart';
import '/NETWORK/base_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../NETWORK/app_exceptions.dart';
import '../NETWORK/network_string.dart';
import '../UTILS/consts.dart';
import '../UTILS/dialog_helper.dart';

class FishController extends GetxController {
  var faqData = <FaqData>[].obs;
  var fishData = <FishData>[].obs;
  var categoryData = <CategoryData>[].obs;
  var isPasswordVisible = true.obs;
  var isEveryone = true.obs;

  //var categoryId = CategoryData().obs;
  String? categoryId;

  Future<void> getFishData(dynamic data) async {
    DialogHelper.showLoading();
    if(data["page"]==1){
      fishData.clear();
    }
    var response =
        await BaseClient().post(getFishApi, data)?.catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    DialogHelper.hideLoading();
    if (response == null) return;
    var sp = FishResponse.fromJson(jsonDecode(await response));
    fishData.addAll(sp.data ?? []);
    //print("==============${fishData.length}");
  }

  Future<void> broadcast(dynamic data) async {
    DialogHelper.showLoading();
    var response =
        await BaseClient().post(broadcastApi, data)?.catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    DialogHelper.hideLoading();

    showSnackBar(response['message'], Colors.green);
  }

  deleteFish(dynamic data) async {
    DialogHelper.showLoading();
    var response = await BaseClient().post(deleteFishApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    if (res['status']) {
      getFishData({
        "page": 1,
        "limit": 20,
        "sortBy": "desc",
        "sortOn": "created_at",
      });
    }
    showSnackBar(res['message'], Colors.green);
  }

  addFish(Map<dynamic, dynamic> data, bool isUpdate) async {
    DialogHelper.showLoading();
    var response =
        await BaseClient().post(isUpdate ? updateFishApi : addFishApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    if (res['status']) {
      getFishData({
        "page": 1,
        "limit": 20,
        "sortBy": "desc",
        "sortOn": "created_at",
      });
    }
    showSnackBar(res['message'], Colors.green);
  }

  Future<void> getFaqData(dynamic data) async {
    DialogHelper.showLoading();
    if(data["page"]==1){
      faqData.clear();
    }
    var response =
        await BaseClient().post(getFaqApi, data)?.catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    DialogHelper.hideLoading();
    if (response == null) return;
    var sp = FaqResponse.fromJson(jsonDecode(await response));
    faqData.value = sp.data ?? [];
    print("==============${faqData.length}");
  }

  Future<void> getCategoryData(dynamic data) async {
    DialogHelper.showLoading();
    if(data["page"]==1){
      categoryData.clear();
    }
    var response =
        await BaseClient().post(getCategoryApi, data)?.catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    DialogHelper.hideLoading();
    if (response == null) return;
    var sp = CategoryResponse.fromJson(jsonDecode(await response));
    categoryData.value = sp.data ?? [];
    print("==============${categoryData.length}");
  }

  addFaq(Map<dynamic, dynamic> data) async {
    DialogHelper.showLoading();
    var response = await BaseClient().post(addFaqApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    if (res['status']) {
      getFaqData({
        "page": 1,
        "limit": 20,
        "sortBy": "desc",
        "sortOn": "created_at",
      });
    }
    showSnackBar(res['message'], Colors.green);
  }

  addCateGory(Map<dynamic, dynamic> data, bool isUpdate) async {
    DialogHelper.showLoading();
    var response = await BaseClient()
        .post(isUpdate ? updateCategoryApi : addCategoryApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    if (res['status']) {
      getCategoryData({
        "page": 1,
        "limit": 20,
        "sortBy": "desc",
        "sortOn": "created_at",
      });
    }
    showSnackBar(res['message'], Colors.green);
  }

  deleteCategory(dynamic data) async {
    DialogHelper.showLoading();
    var response = await BaseClient().post(deleteCategoryApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    if (res['status']) {
      getCategoryData({
        "page": 1,
        "limit": 20,
        "sortBy": "desc",
        "sortOn": "created_at",
      });
    }
    showSnackBar(res['message'], Colors.green);
  }

  void deleteFaq(Map<String, String> data) async {
    DialogHelper.showLoading();
    var response = await BaseClient().post(deleteFaqApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    if (res['status']) {
      getFaqData({
        "page":1,
        "limit": 20,
        "sortBy": "desc",
        "sortOn": "created_at",
      });
    }
    showSnackBar(res['message'], Colors.green);
  }
}
