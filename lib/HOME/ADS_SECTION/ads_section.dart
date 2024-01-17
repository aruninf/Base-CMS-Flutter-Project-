import '/CONTROLERS/user_conntroller.dart';
import '/MODELS/ad_response.dart';
import '/WIDGETS/cancel_done_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CUSTOM_WIDGETS/custom_text_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/consts.dart';
import '../../WIDGETS/header_search.dart';

class AdsSection extends StatelessWidget {
  AdsSection({super.key});

  final controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderSearchBar(
            title: "Advertising Management",
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const Text(
                'Active Ads',
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
                          child: AddNewAdWidget(
                              //userData: userData,
                              ),
                        ));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: fishColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(width: 1, color: fishColor)),
                  ),
                  child: const Text(
                    'Add New',
                    style: TextStyle(
                        color: secondaryColor, fontWeight: FontWeight.w700),
                  )),
            ],
          ),
          Expanded(
              child: Obx(() => controller.adsData.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 1350 ? 3 : 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.9),
                      itemCount: controller.adsData.length,
                      itemBuilder: (context, index) =>
                          AdsItemRow(adsData: controller.adsData[index]),
                    )
                  : const Center(
                      child: Text(
                        'No Post Found!',
                        style: TextStyle(color: secondaryColor),
                      ),
                    )))
        ],
      ),
    );
  }
}

class AdsItemRow extends StatelessWidget {
  AdsItemRow({super.key, required this.adsData});

  final AdData adsData;
  final controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white70, width: 1.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                adsData.businessName ?? '',
                style: const TextStyle(
                    fontFamily: "Rodetta",
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: secondaryColor),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Get.dialog(
                        barrierDismissible: true,
                        Dialog(
                          backgroundColor: Colors.transparent,
                          child: AddNewAdWidget(
                            adsData: adsData,
                          ),
                        ));
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(width: 1, color: btnColor)),
                  ),
                  child: const Text(
                    'Edit',
                    style:
                        TextStyle(color: btnColor, fontWeight: FontWeight.w700),
                  )),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                  onPressed: () => deleteAds(adsData),
                  style: TextButton.styleFrom(
                    backgroundColor: fishColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(width: 1, color: fishColor)),
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                        color: secondaryColor, fontWeight: FontWeight.w700),
                  )),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Start Date : ${formatDateTimeToMMM(adsData.startDate ?? '')}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: btnColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "End Date : ${formatDateTimeToMMM(adsData.endDate ?? '')}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: btnColor),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "\$${adsData.adSaleAmt}",
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: fishColor),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                adsData.adImg ?? '',
                width: Get.width,
                height: MediaQuery.of(context).size.width > 1450
                    ? Get.height * 0.35
                    : Get.height * 0.35,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  fishingImage,
                  width: Get.width,
                  height: MediaQuery.of(context).size.width > 1450
                      ? Get.height * 0.35
                      : Get.height * 0.35,
                  fit: BoxFit.cover,
                ),
              )),
          const SizedBox(
            height: 16,
          ),
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: adsData.status == 1
                    ? Colors.green
                    : Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                adsData.status == 1 ? "Active" : 'Inactive',
                style: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.w700),
              )),
        ],
      ),
    );
  }

  deleteAds(AdData adsData) {
    var data = {"id": adsData.id};
    controller.deleteAds(data);
  }
}

class AddNewAdWidget extends StatelessWidget {
  AddNewAdWidget({super.key, this.adsData});

  final controller = Get.find<UserController>();
  final businessName = TextEditingController().obs;
  final salesAmount = TextEditingController().obs;
  final linkController = TextEditingController().obs;

  final AdData? adsData;

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
        if (adsData?.id != null) {
          controller.uploadImageUrl.value = adsData?.adImg ?? '';
          businessName.value.text = adsData?.businessName ?? '';
          salesAmount.value.text = adsData?.adSaleAmt ?? '';
          linkController.value.text = adsData?.link ?? '';
          controller.selectStartDate.value = adsData?.startDate ?? '';
          controller.selectEndDate.value = adsData?.endDate ?? '';
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
                  controller.uploadImage.value,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    fishingImage,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const CustomText(
              text: "Select Image",
              color: secondaryColor,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              hintText: "Business name",
              controller: businessName.value,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              hintText: "Add Sales Amount",
              controller: salesAmount.value,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              hintText: "Link",
              controller: linkController.value,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: btnColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          controller.selectStartDate.value,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: primaryColor),
                        ),
                      ),
                      onPressed: () => controller.selectDate(context, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: btnColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          controller.selectEndDate.value,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: primaryColor),
                        ),
                      ),
                      onPressed: () => controller.selectDate(context, 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            CommonCancelAndCreateButton(
              submit: () {
                if (controller.uploadImageUrl.value.length < 3) {
                  Get.snackbar('Required!', 'Please select image',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }

                if (businessName.value.text.length < 3) {
                  Get.snackbar(
                      'Required!', 'Please enter the correct Business Name',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }
                if (salesAmount.value.text.isEmpty) {
                  Get.snackbar(
                      'Required!', 'Please enter the correct sales amount',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }

                if (linkController.value.text.length < 3) {
                  Get.snackbar('Required!', 'Please enter the correct link',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }

                if (controller.selectStartDate.value.isEmpty) {
                  Get.snackbar(
                      'Required!', 'Please enter the correct start date',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }

                if (controller.selectEndDate.value.isEmpty) {
                  Get.snackbar('Required!', 'Please enter the correct end date',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }

                var data = {
                  "id": adsData?.id,
                  "business_name": businessName.value.text.trim(),
                  "category": "2",
                  "ad_sale_amount": salesAmount.value.text.trim(),
                  "link": linkController.value.text.trim(),
                  "start_date": controller.selectStartDate.value.trim(),
                  "end_date": controller.selectEndDate.value.trim(),
                  "ad_image": controller.uploadImageUrl.value
                };
                controller.addAd(
                    data, (adsData?.businessName ?? '').isNotEmpty);
                Get.back();
              },
              btnText: (adsData?.businessName ?? '').isNotEmpty
                  ? 'Update'
                  : 'Create',
            )
          ],
        );
      }),
    );
  }
}
