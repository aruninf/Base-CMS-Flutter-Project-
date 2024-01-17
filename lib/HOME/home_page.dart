import '/CONTROLERS/fish_conntroller.dart';
import '/UTILS/app_color.dart';
import '/WIDGETS/menu.dart';
import '/WIDGETS/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CONTROLERS/home_conntroller.dart';
import '../CONTROLERS/user_conntroller.dart';
import 'ADS_SECTION/ads_section.dart';
import 'ARTICLE_BLOG_SECTION/article_section.dart';
import 'BROADCAST_SECTION/broadcast_section.dart';
import 'CATEGORY_SECTION/category_section.dart';
import 'DASHBOARD_SECTION/dashboard_section.dart';
import 'FAQ_SECTION/faq_section.dart';
import 'FISH_SECTION/fish_section.dart';
import 'INBOX_SECTION/inbox_section.dart';
import 'POST_SECTION/post_management_section.dart';
import 'PRIVACY_POLICY_SECTION/privacy_policy_section.dart';
import 'USER_SECTION/user_section.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final homeController = Get.put(HomeController());
  final controller = Get.find<UserController>();
  final fishController = Get.put(FishController());

  var data = {
    "page": 1,
    "limit": 20,
    "type":1,
    "sortBy": "desc",
    "sortOn": "created_at",
  };

  void getUser() {
    Future.delayed(Duration.zero, () => controller.getUserData(data),);
  }

  void getDashboardData() {
    Future.delayed(Duration.zero, () {
      //homeController.getDashboardData();
      //controller.getUserData(data);
    });
  }

  void getFaqData() {
    Future.delayed(Duration.zero, () => fishController.getFaqData(data));
  }

  void getFishData() {
    Future.delayed(Duration.zero, () => fishController.getFishData(data));
    Future.delayed(Duration.zero, () => fishController.getCategoryData(data));
  }

  void getCategoriesData() {
    Future.delayed(Duration.zero, () => fishController.getCategoryData(data));
  }

  void getAllPosts() {
    Future.delayed(Duration.zero, () => homeController.getPostsData(data));
  }

  void getPrivacyPolicy() {
    Future.delayed(Duration.zero, () => homeController.getTermsPolicyContent());
  }

  void getInboxData() {
    Future.delayed(Duration.zero, () => controller.getInboxData(data));
  }

  void getBroadcastData() {
    print("Broadcast section call");
  }

  void getArticlesData() {
    Future.delayed(Duration.zero, () => controller.getIsArticles(data, true));
    Future.delayed(Duration.zero, () => controller.getIsArticles(data, false));
  }

  void getAdsData() {
    Future.delayed(Duration.zero, () => controller.getAdsData(data));
  }

  void logout(BuildContext conte) {
    showDialog(
      context: conte,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to Logout?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () async {
                Get.find<UserController>().logoutUser();
              },
            )
          ],
        );
      },
    );
  }

  void _onItemTapped(int index, BuildContext context) async {
    print("Index===================$index");
    index != 11 ? homeController.selectedIndex.value = index : 0;
    index == 0
        ? getDashboardData()
        : index == 1
            ? getUser()
            : index == 2
                ? getFishData()
                : index == 3
                    ? getCategoriesData()
                    : index == 4
                        ? getAllPosts()
                        : index == 5
                            ? getPrivacyPolicy()
                            : index == 6
                                ? getFaqData()
                                : index == 7
                                    ? getInboxData()
                                    : index == 8
                                        ? getBroadcastData()
                                        : index == 9
                                            ? getArticlesData()
                                            : index == 10
                                                ? getAdsData()
                                                : index == 11
                                                    ? logout(context)
                                                    : nothing();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SideMenu(
                  click: (i) {
                    _onItemTapped(i, context);
                  },
                ),
                Expanded(
                  child: IndexedStack(
                    index: homeController.selectedIndex.value,
                    children: [
                      DashBoardSection(),
                      UserSection(),
                      FishSection(),
                      CategorySection(),
                      PostManagementSection(),
                      StaticContentSection(),
                      FAQSection(),
                      InboxSection(),
                      BroadcastSection(),
                      ArticleSection(),
                      AdsSection(),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  nothing() {}
}
