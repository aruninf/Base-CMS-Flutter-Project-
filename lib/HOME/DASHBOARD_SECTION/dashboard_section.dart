import '/CONTROLERS/fish_conntroller.dart';
import '/CONTROLERS/home_conntroller.dart';
import '/CONTROLERS/user_conntroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CUSTOM_WIDGETS/common_button.dart';
import '../../UTILS/app_color.dart';
import '../../WIDGETS/header_search.dart';
import 'chart_widget.dart';
import 'google_map_widget.dart';
import 'most_receent_user.dart';
import 'total_count_row_widget.dart';

class DashBoardSection extends StatelessWidget {
  DashBoardSection({super.key});

  final controller = Get.find<HomeController>();
  final fishController = Get.find<FishController>();

  @override
  Widget build(BuildContext context) {
    //controller.getDashboardData();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const HeaderSearchBar(
            title: "Dashboard",
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(() => Row(
                children: [
                  DashBoardTotalWidget(
                    title: "Monthly Badges",
                    value: "30${controller.dashboardData.value.mostTaggedFish ?? 0}",
                    isFilter: true,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  DashBoardTotalWidget(
                    title: "Quarterly Badges",
                    value:
                        "422",
                    isFilter: true,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  DashBoardTotalWidget(
                    title: "6 Months Badge",
                    value:
                        "118",
                    isFilter: true,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  DashBoardTotalWidget(
                    title: "12 Months Badge",
                    value: "34",
                    isFilter: true,
                  ),
                  const SizedBox(
                    width: 16,
                  ),

                ],
              )),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const ChartWidget(),
                    const SizedBox(
                      height: 16,
                    ),
                    MostRecentUserWidget(),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: CommonButton(
                            btnBgColor: fishColor,
                            btnTextColor: Colors.white,
                            btnText: 'Create Fish',
                            onClick: () async {
                              var data = {
                                "page": "1",
                                "limit": "20",
                                "sortBy": "desc",
                                "sortOn": "created_at",
                              };
                              fishController.getFishData(data);
                              fishController.getCategoryData(data);
                              controller.selectedIndex.value = 2;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: CommonButton(
                            btnBgColor: secondaryColor,
                            btnTextColor: Colors.white,
                            btnText: 'Create AD',
                            onClick: () {
                              var data = {
                                "page": "1",
                                "limit": "20",
                                "sortBy": "desc",
                                "sortOn": "created_at",
                              };
                              Get.find<UserController>().getAdsData(data);
                              controller.selectedIndex.value = 10;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: CommonButton(
                            btnBgColor: fishColor,
                            btnTextColor: Colors.white,
                            btnText: 'Create Category',
                            onClick: () async {
                              var data = {
                                "page": "1",
                                "limit": "20",
                                "sortBy": "desc",
                                "sortOn": "created_at",
                              };
                              fishController.getCategoryData(data);
                              controller.selectedIndex.value = 3;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
