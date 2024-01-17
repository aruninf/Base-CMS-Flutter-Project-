import '/CONTROLERS/fish_conntroller.dart';
import '/WIDGETS/cancel_done_button.dart';
import '/WIDGETS/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CUSTOM_WIDGETS/custom_text_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MODELS/category_response.dart';
import '../../UTILS/app_color.dart';
import '../../WIDGETS/header_search.dart';

class CategorySection extends StatelessWidget {
  CategorySection({super.key});

  final controller = Get.find<FishController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: HeaderSearchBar(
            title: "Category Management",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              const Text(
                'Fish Categories',
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
                          child: AddCategoryWidget(
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
                    'Add New Category',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
        CategoryListWidget()
      ],
    );
  }
}

class AddCategoryWidget extends StatelessWidget {
  AddCategoryWidget({super.key, this.data});

  final controller = Get.find<FishController>();
  final categoryName = TextEditingController().obs;
  final CategoryData? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context) ? Get.width / 3 : Get.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: primaryColor,
          border: Border.all(color: fishColor, width: 1),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: (data?.name ?? '').isNotEmpty
                ? "Update Fish Category"
                : "Add New Fish Category",
            sizeOfFont: 16,
            weight: FontWeight.w800,
            color: secondaryColor,
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(() {
            categoryName.value.text = data?.name ?? '';
            return CommonTextField(
              hintText: "Category name",
              controller: categoryName.value,
            );
          }),
          const SizedBox(
            height: 16,
          ),
          CommonCancelAndCreateButton(
            submit: () {
              if (categoryName.value.text.length < 3) {
                Get.snackbar('Required!', 'Please enter the correct Name',
                    colorText: Colors.orange, snackPosition: SnackPosition.TOP);
                return;
              }
              var param = {
                'id': data?.id,
                "name": categoryName.value.text.trim()
              };
              Get.back();
              controller.addCateGory(param, (data?.name ?? '').isNotEmpty);
              categoryName.value.text = "";
            },
            btnText: (data?.name ?? '').isNotEmpty
                ? "Update Category"
                : 'Add Category',
          )
        ],
      ),
    );
  }
}

class CategoryListWidget extends StatelessWidget {
  CategoryListWidget({super.key});

  final controller = Get.find<FishController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: controller.categoryData.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 0.56,
                  ),
                  itemCount: controller.categoryData.length,
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: CustomText(
                      text: "${controller.categoryData[index].name}",
                      color: secondaryColor,
                      sizeOfFont: 16,
                      weight: FontWeight.w700,
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
                                      child: AddCategoryWidget(
                                        data: controller.categoryData[index],
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
                                  "id":
                                      '${controller.categoryData[index].id ?? 0}'
                                };
                                controller.deleteCategory(data);
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
