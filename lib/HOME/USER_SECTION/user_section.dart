import '/CONTROLERS/user_conntroller.dart';
import '/CUSTOM_WIDGETS/custom_text_style.dart';
import '/MODELS/user_response.dart';
import '/UTILS/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../UTILS/consts.dart';
import '../../WIDGETS/header_search.dart';
import '../DASHBOARD_SECTION/widgets/user_info_widget.dart';

class UserSection extends StatefulWidget {
  UserSection({super.key});

  @override
  State<UserSection> createState() => _UserSectionState();
}

class _UserSectionState extends State<UserSection> {
  final controller = Get.find<UserController>();
  final search = TextEditingController().obs;

  final scrollController = ScrollController();
  var page = 1;

  @override
  void initState() {
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)) {
        setState(() {
          page += 1;
          //add api for load the more data according to new page
          Future.delayed(
            Duration.zero,
            () async {
              var data = {
                "sortBy": "desc",
                "sortOn": "created_at",
                "page": page,
                "limit": 20,
              };
              controller.getUserData(data);
            },
          );
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child:  HeaderSearchBar(
              title: "User Management",
              controller: search.value,
              onChanges: () {
                var data = {
                  "sortBy": "desc",
                  "sortOn": "created_at",
                  "page": 1,
                  "limit": 20,
                  "filter": search.value.text
                };
                controller.getUserData(data);
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 2, color: btnColor)),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: "Name      ",
                            color: secondaryColor,
                            weight: FontWeight.w900,
                            sizeOfFont: 16,
                          ),
                        ),
                        Expanded(
                          child: CustomText(
                            text: "Location",
                            color: secondaryColor,
                            weight: FontWeight.w900,
                            sizeOfFont: 16,
                          ),
                        ),
                        Expanded(
                          child: CustomText(
                            text: "Age ",
                            color: secondaryColor,
                            weight: FontWeight.w900,
                            sizeOfFont: 16,
                          ),
                        ),
                        Expanded(
                          child: CustomText(
                            text: "Gender",
                            color: secondaryColor,
                            weight: FontWeight.w900,
                            sizeOfFont: 16,
                          ),
                        ),
                        Expanded(
                          child: CustomText(
                            text: "Status",
                            color: secondaryColor,
                            weight: FontWeight.w900,
                            sizeOfFont: 16,
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
                  Expanded(
                    child: Obx(
                      () => controller.userData.isNotEmpty
                          ? ListView.builder(
                              controller: scrollController,
                              padding: EdgeInsets.zero,
                              itemCount: controller.userData.length,
                              itemBuilder: (context, index) => UserItemWidget(
                                userData: controller.userData[index],
                              ),
                            )
                          : const Center(
                              child: Text(
                                "No Record Found!",
                                style: TextStyle(color: secondaryColor),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UserItemWidget extends StatelessWidget {
  UserItemWidget({super.key, required this.userData});

  final controller = Get.find<UserController>();

  final UserData userData;
  final userStatus = false.obs;

  void openDetailDialog(UserData userData) {
    Get.dialog(
        barrierDismissible: true,
        Dialog(
          backgroundColor: Colors.transparent,
          child: ShowUserInfoWidget(
            userData: userData,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    userStatus.value = userData.status == 1 ? true : false;
    return InkWell(
      onTap: () {
        openDetailDialog(userData);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    text: userData.name ?? '',
                    color: btnColor,
                    weight: FontWeight.w600,
                    sizeOfFont: 15,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text:
                        "${(userData.locationId ?? []).isEmpty ? '--' : userData.locationId}",
                    color: btnColor,
                    weight: FontWeight.w600,
                    sizeOfFont: 15,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: "${calculateAge(userData.dob ?? '')} y/o",
                    color: btnColor,
                    weight: FontWeight.w600,
                    sizeOfFont: 15,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: "${userData.gender}",
                    color: btnColor,
                    weight: FontWeight.w600,
                    sizeOfFont: 15,
                  ),
                ),
                Expanded(
                  child: Obx(() => Align(
                        alignment: Alignment.centerLeft,
                        child: Switch(
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green,
                          value: userStatus.value,
                          onChanged: (value) async {
                            userStatus.value = !userStatus.value;
                            var data = {
                              "id": userData.id,
                              "status": userStatus.value ? 1 : 0
                            };
                            controller.updateUserStatus(data);
                          },
                        ),
                      )),
                ),
                const Expanded(
                  child: Icon(
                    Icons.more_horiz,
                    size: 32,
                    color: btnColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white30,
            width: double.infinity,
            height: 0.78,
          ),
        ],
      ),
    );
  }
}
