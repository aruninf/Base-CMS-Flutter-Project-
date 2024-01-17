import '/CONTROLERS/fish_conntroller.dart';
import '/MODELS/faq_response.dart';
import '/WIDGETS/cancel_done_button.dart';
import '/WIDGETS/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CUSTOM_WIDGETS/custom_text_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../WIDGETS/header_search.dart';

class FAQSection extends StatelessWidget {
  FAQSection({super.key});

  final controller = Get.find<FishController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: HeaderSearchBar(
            title: "FAQ'S",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              const Text(
                "FAQ'S",
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
                          child: AddFaqWidget(
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
                    'Create New FAQ',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
        FaqListWidget()
      ],
    );
  }
}

class AddFaqWidget extends StatelessWidget {
  AddFaqWidget({super.key, this.data});

  final controller = Get.find<FishController>();
  final question = TextEditingController().obs;
  final answer = TextEditingController().obs;
  final FaqData? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isDesktop(context) ? Get.width / 3 : Get.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: primaryColor,
          border: Border.all(color: fishColor, width: 1),
          borderRadius: BorderRadius.circular(16)),
      child: Obx(() {
        question.value.text = data?.question ?? '';
        answer.value.text = data?.answer ?? '';
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonTextField(
              hintText: "Question",
              controller: question.value,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              hintText: "Answer",
              controller: answer.value,
              maxLine: 4,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonCancelAndCreateButton(
              submit: () {
                if (question.value.text.length < 3) {
                  Get.snackbar('Required!', 'Please enter the correct Question',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }
                if (answer.value.text.length < 3) {
                  Get.snackbar('Required!', 'Please enter the correct Answer',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }
                var param = {
                  'id': data?.id,
                  "question": question.value.text.trim(),
                  "answer": answer.value.text.trim()
                };
                Get.back();
                controller.addFaq(param);
                question.value.text = "";
                answer.value.text = "";
              },
              btnText:
                  (data?.question ?? '').isNotEmpty ? "Update FAQ" : 'Add FAQ',
            )
          ],
        );
      }),
    );
  }
}

class FaqListWidget extends StatelessWidget {
  FaqListWidget({super.key});

  final controller = Get.find<FishController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: controller.faqData.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.all(16),
                  // separatorBuilder: (context, index) => const Divider(
                  //   thickness: 0.56,
                  // ),
                  itemCount: controller.faqData.length,
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: CustomText(
                      text: "${controller.faqData[index].question}",
                      color: fishColor,
                      sizeOfFont: 18,
                      weight: FontWeight.w700,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: CustomText(
                        text: "${controller.faqData[index].answer}",
                        color: secondaryColor,
                      ),
                    ),
                    trailing: SizedBox(
                      height: 30,
                      child: TextButton(
                          onPressed: () async {
                            var data = {
                              "id": '${controller.faqData[index].id ?? 0}'
                            };
                            controller.deleteFaq(data);
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
