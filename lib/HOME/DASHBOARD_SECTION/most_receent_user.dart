import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CONTROLERS/user_conntroller.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../USER_SECTION/user_section.dart';

class MostRecentUserWidget extends StatelessWidget {
  MostRecentUserWidget({super.key});

  final controller = Get.find<UserController>();

  void getDashboardData() {
    var data = {
      "page": "1",
      "limit": "20",
      "sortBy": "desc",
      "sortOn": "created_at",
    };
    Future.delayed(
      Duration.zero,
      () => controller.getUserData(data),
    );
  }

  @override
  Widget build(BuildContext context) {
    //getDashboardData();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: btnColor, width: 2),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Most Recent Users',
                  style: TextStyle(
                    color: fishColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Most Recent",
                      style: TextStyle(color: btnColor, fontSize: 14),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: btnColor,
                      size: 24,
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    text: "Name      ",
                    color: secondaryColor,
                    weight: FontWeight.w700,
                    sizeOfFont: 14,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: "Location",
                    color: secondaryColor,
                    weight: FontWeight.w700,
                    sizeOfFont: 14,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: "Age ",
                    color: secondaryColor,
                    weight: FontWeight.w700,
                    sizeOfFont: 14,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: "Gender",
                    color: secondaryColor,
                    weight: FontWeight.w700,
                    sizeOfFont: 14,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: "Status",
                    color: secondaryColor,
                    weight: FontWeight.w700,
                    sizeOfFont: 14,
                  ),
                ),
                Expanded(
                  child: Icon(
                    Icons.more_horiz,
                    size: 15,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white30,
            width: double.infinity,
            height: 1,
          ),
          Obx(
            () => controller.userData.isNotEmpty
                ? SizedBox(
                    height: Get.height * 0.33,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.userData.length,
                      itemBuilder: (context, index) => UserItemWidget(
                        userData: controller.userData[index],
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                      "No Record Found!",
                      style: TextStyle(color: secondaryColor),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
