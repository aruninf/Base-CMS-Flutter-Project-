import 'dart:async';
import 'dart:convert';

import '/CONTROLERS/user_conntroller.dart';
import '/MODELS/content_response.dart';
import '/MODELS/dashboard_response.dart';
import '/MODELS/post_response.dart';
import '/NETWORK/base_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../MODELS/top_spots_response.dart';
import '../NETWORK/app_exceptions.dart';
import '../NETWORK/network_string.dart';
import '../UTILS/consts.dart';
import '../UTILS/dialog_helper.dart';

class HomeController extends GetxController {
  var uploadImageUrl = ''.obs;
  var contentData = <ContentData>[].obs;
  var postData = <PostData>[].obs;
  var dashboardData = DashboardData().obs;
  var isPasswordVisible = true.obs;
  var isEditTerms = false.obs;
  var isEditPolicy = false.obs;
  var controller = Get.find<UserController>();
  var googleMapController = Completer<GoogleMapController>().obs;
  final markers = <Marker>[].obs;
  final topSpot = <TopSpot>[].obs;
  late BitmapDescriptor myIcon;
  final listOfMenu = [
    "images/home_icon.png",
    "images/user_icon.png",
    "images/quiz_icon.png",
    "images/users_icon.png",
    "images/after_users_icon.png",
    "images/let_connect_icon.png",
    "images/faq_icon.png",
    "images/static_content_icon.png",
    "images/logout_icon.png",
  ].obs;

  final listOfLocation = [
    "New South Wales (NSW)",
    "Victoria (VIC)",
    "Queensland (QLD)",
    "South Australia (SA)",
    "Western Australia (WA)",
    "Tasmania (TAS)",
    "Australian Capital Territory (ACT)",
    "Northern Territory (NT)",
  ].obs;

  var selectedIndex = 0.obs;
  var selectedLocation = 0.obs;
  var initialCameraPosition = const CameraPosition(
    target: LatLng(-29.521097058397896, 135.05382333850554),
    // San Francisco, CA coordinates
    zoom: 8.0,
  ).obs;

  @override
  void onReady() async {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(24, 24)),
            'images/top_spot_icon.png')
        .then((onValue) {
      myIcon = onValue;
    });

    //movePosition(-29.521097058397896, 135.05382333850554);
    super.onReady();

    //getTopSpots({"type": 1});
    //addMarker();
  }

  Future<void> movePosition(double lat, double long) async {
    final GoogleMapController controller =
        await googleMapController.value.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long), // San Francisco, CA coordinates
      zoom: 4.0,
    )));
  }

  void addMarker() {
    markers.value = const [
      Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId('SomeId1'),
          position: LatLng(-32.23802154105024, 146.28119669514828),
          infoWindow: InfoWindow(title: 'New South Wales (NSW)')),
      Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId('SomeId2'),
          position: LatLng(-36.9828112132686, 144.2686501261222),
          infoWindow: InfoWindow(title: 'Victoria (VIC)')),
      Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId('SomeId3'),
          position: LatLng(-22.633166402197528, 144.84005532902137),
          infoWindow: InfoWindow(title: 'Queensland (QLD)')),
      Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId('SomeId4'),
          position: LatLng(-29.521097058397896, 135.05382333850554),
          infoWindow: InfoWindow(title: 'South Australia (SA)')),
      Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId('SomeId5'),
          position: LatLng(-26.149853400088684, 121.88542090863693),
          infoWindow: InfoWindow(title: 'Western Australia (WA)')),
      Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId('SomeId6'),
          position: LatLng(-41.95706819204696, 146.520821377283),
          infoWindow: InfoWindow(title: 'Tasmania (TAS)')),
      Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId('SomeId7'),
          position: LatLng(-35.43367677006962, 148.9697532888674),
          infoWindow: InfoWindow(title: 'Australian Capital Territory (ACT)')),
      Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId('SomeId8'),
          position: LatLng(-19.427257281941447, 133.41503280664466),
          infoWindow: InfoWindow(title: 'Northern Territory (NT)')),
    ];
  }

  ///💥💥💥💥💥💥💥 Top Spots Markers 💥💥💥💥💥💥💥

  Future<void> getTopSpots(dynamic data) async {
    markers.clear();
    var response =
        await BaseClient().post(getTopSpotsApi, data)?.catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    DialogHelper.hideLoading();
    if (response == null) return;
    final post = TopSpotResponse.fromJson(jsonDecode(await response));
    final List<int> fixedList =
        Iterable<int>.generate((post.data ?? []).length).toList();

    for (var e in fixedList) {
      print(e);
      markers.add(
        Marker(
          icon: myIcon,
          markerId: MarkerId(e.toString()),
          position: LatLng(
            (post.data ?? [])[e].latitude ?? 37.775834,
            (post.data ?? [])[e].longitude ?? -122.400417,
          ),
          infoWindow: InfoWindow(title: (post.data ?? [])[e].address),
        ),
      );
    }
  }

  Future<void> getPostsData(dynamic data) async {
    DialogHelper.showLoading();
    if(data["page"]==1){
      postData.clear();
    }
    var response =
        await BaseClient().post(getPostApi, data)?.catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    DialogHelper.hideLoading();
    if (response == null) return;
    var sp = PostResponse.fromJson(jsonDecode(await response));
    postData.addAll(sp.data ?? []);
    //print("==============${postData.length}");
  }

  Future<void> getDashboardData() async {
    var response = await BaseClient().get(getDashboardApi).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    if (response == null) return;
    var sp = DashboardResponse.fromJson(jsonDecode(await response));
    dashboardData.value = sp.data ?? DashboardData();
    //print("==============${postData.length}");
  }

  void addTermsAndPolicy(String content, String s) async {
    if (content.length < 3) {
      Get.snackbar('Required!', 'Please enter the correct content',
          colorText: Colors.orange, snackPosition: SnackPosition.TOP);
      return;
    }
    var data = {"id": s, "content": content};

    DialogHelper.showLoading();
    var response = await BaseClient().post(addContentApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    if (res['status']) {
      getTermsPolicyContent();
    }
    showSnackBar(res['message'], Colors.green);
  }

  Future<void> getTermsPolicyContent() async {
    DialogHelper.showLoading();
    var response = await BaseClient().get(getContentApi).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        print(error);
      }
    });
    DialogHelper.hideLoading();
    if (response == null) return;
    var sp = ContentResponse.fromJson(jsonDecode(await response));
    contentData.value = sp.data ?? [];
    //print("==============${contentData.length}");
  }

  void updatePost(bool value, String postId) async {
    var data = {"post_id": postId, "status": value};

    DialogHelper.showLoading();
    var response = await BaseClient().post(updatePostStatusApi, data);
    DialogHelper.hideLoading();
    if (response == null) return;
    var res = jsonDecode(await response);
    if (res['status']) {
      var param = {
        "page": 1,
        "limit": 20,
        "type":1,
        "sortBy": "desc",
        "sortOn": "created_at",
      };
      getPostsData(param);
    }
    showSnackBar(res['message'], Colors.green);
  }
}
