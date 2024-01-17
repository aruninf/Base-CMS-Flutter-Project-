
import '/CONTROLERS/fish_conntroller.dart';
import '/CONTROLERS/user_conntroller.dart';
import '/CUSTOM_WIDGETS/category_dropdown.dart';
import '/MODELS/fish_response.dart';
import '/UTILS/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CUSTOM_WIDGETS/custom_text_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../WIDGETS/cancel_done_button.dart';
import '../../WIDGETS/header_search.dart';

class FishSection extends StatelessWidget {
  FishSection({super.key});

  final controller = Get.find<FishController>();
  final categoryName = TextEditingController().obs;
  final search=TextEditingController().obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() =>   Padding(
          padding: const EdgeInsets.all(16.0),
          child: HeaderSearchBar(
            title: "Fish Management",
            controller: search.value,
            onChanges: () {
              var data = {
                "sortBy": "desc",
                "sortOn": "created_at",
                "page": 1,
                "limit": 20,
                "filter": search.value.text
              };
              controller.getFishData(data);
            },
          ),
        ),),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              const Text(
                'Manage Fish',
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () async {
                    Get.dialog(
                        barrierDismissible: true,
                        Dialog(
                          backgroundColor: Colors.transparent,
                          child: AddFishWidget(
                              //userData: userData,
                              ),
                        ));
                  },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: fishColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                              width: 0.56, color: Colors.white))),
                  child: const Text(
                    'Add New Fish',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
        FishListWidget()
      ],
    );
  }
}

class AddFishWidget extends StatelessWidget {
  AddFishWidget({super.key, this.fishData});

  final controller = Get.find<FishController>();
  final fishLocalName = TextEditingController().obs;
  final fishScientificName = TextEditingController().obs;
  final fishInfo = TextEditingController().obs;
  final legalSize = TextEditingController().obs;
  final FishData? fishData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 3,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: primaryColor,
          border: Border.all(color: fishColor, width: 1),
          borderRadius: BorderRadius.circular(16)),
      child: Obx(() {
        if (fishData?.id != null) {
          //Get.find<UserController>().uploadImageUrl.value = fishData?.fishImage ?? '';
          controller.categoryId = fishData?.catId.toString();
          fishLocalName.value.text = fishData?.localName ?? '';
          fishScientificName.value.text = fishData?.scientificName ?? '';
          fishInfo.value.text = fishData?.info ?? '';
          legalSize.value.text = fishData?.legalSize ?? '';
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () async {
                await Get.find<UserController>().getImage();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(
                  Get.find<UserController>().uploadImage.value,
                  height: 100,
                  width: 130,

                  errorBuilder: (context, error, stackTrace) => Image.network(
                    fishData?.fishImage ?? "" ,
                    height: 130,
                    width: 100,

                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      "images/fish_placeHolder.png",
                      height: 130,
                      width: 100,

                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const CustomText(
              text: "Select Fish Image",
              color: secondaryColor,
            ),
            const SizedBox(
              height: 16,
            ),
            CategoryDropdown(
                dropdownValue: controller.categoryId,
                callback: (val) {
                  controller.categoryId = val;
                  print(controller.categoryId);
                }),
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              hintText: "Local fish name",
              controller: fishLocalName.value,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              hintText: "Fish scientific name",
              controller: fishScientificName.value,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              hintText: "Fish info",
              maxLine: 4,
              controller: fishInfo.value,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              hintText: "Legal size",
              textInputType: TextInputType.number,
              controller: legalSize.value,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonCancelAndCreateButton(
              submit: () {
                if (Get.find<UserController>().uploadImageUrl.value.length <
                    3) {
                  Get.snackbar('Required!', 'Please select image',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }
                if ((controller.categoryId ?? '').isEmpty) {
                  Get.snackbar('Required!', 'Please select fish category',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }
                if (fishLocalName.value.text.length < 3) {
                  Get.snackbar(
                      'Required!', 'Please enter the correct Local Name',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }
                if (fishScientificName.value.text.length < 3) {
                  Get.snackbar('Required!',
                      'Please enter the correct fish Scientific Name',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }

                if (fishInfo.value.text.length < 3) {
                  Get.snackbar(
                      'Required!', 'Please enter the correct fish info',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }

                if (legalSize.value.text.isEmpty) {
                  Get.snackbar(
                      'Required!', 'Please enter the correct fish legal size',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }

                var data = {
                  "id": fishData?.id,
                  "cat_id": controller.categoryId,
                  "local_name": fishLocalName.value.text.trim(),
                  "scientific_name": fishScientificName.value.text.trim(),
                  "fish_image": Get.find<UserController>().uploadImageUrl.value,
                  "legal_size": legalSize.value.text.trim(),
                  "info": fishInfo.value.text.trim(),
                  "conservation_status": "Least Concern"
                };
                controller.addFish(
                    data, (fishData?.localName ?? '').isNotEmpty);
                Get.back();
              },
              btnText: (fishData?.localName ?? '').isNotEmpty
                  ? 'Update Fish'
                  : 'Create Fish',
            )
          ],
        );
      }),
    );
  }
}

class FishListWidget extends StatefulWidget {
  FishListWidget({super.key});

  @override
  State<FishListWidget> createState() => _FishListWidgetState();
}

class _FishListWidgetState extends State<FishListWidget> {
  final controller = Get.find<FishController>();
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
              controller.getFishData(data);
            },
          );
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: controller.fishData.isNotEmpty
              ? ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 0.56,
                  ),
                  itemCount: controller.fishData.length,
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "${controller.fishData[index].fishImage}",
                        height: 80,
                        width: 80,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          "images/fish_placeHolder.png",
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                    title: CustomText(
                      text:
                          "${controller.fishData[index].localName} ( ${controller.fishData[index].scientificName} )",
                      color: fishColor,
                      sizeOfFont: 16,
                      weight: FontWeight.w700,
                    ),
                    subtitle: CustomText(
                      text: "${controller.fishData[index].categoryName}",
                      color: secondaryColor,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 30,
                          child: TextButton(
                              onPressed: () async {
                                Get.dialog(
                                    barrierDismissible: true,
                                    Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: AddFishWidget(
                                        fishData: controller.fishData[index],
                                      ),
                                    ));
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  side: const BorderSide(
                                      width: 0.56, color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          height: 30,
                          child: TextButton(
                              onPressed: () async {
                                var data = {
                                  "id": '${controller.fishData[index].id ?? 0}'
                                };
                                controller.deleteFish(data);
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: fishColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          width: 0.56, color: Colors.white))),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    'No Record Found!',
                    style: TextStyle(color: secondaryColor),
                  ),
                ),
        ));
  }
}
