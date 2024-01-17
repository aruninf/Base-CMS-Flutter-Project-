import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CONTROLERS/home_conntroller.dart';
import '../../UTILS/app_color.dart';
import '../../WIDGETS/header_search.dart';

class StaticContentSection extends StatelessWidget {
  StaticContentSection({super.key});

  final homeController = Get.find<HomeController>();
  final termsText = TextEditingController().obs;
  final policyText = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.contentData.isNotEmpty) {
        termsText.value.text = homeController.contentData[0].content ?? '';
        policyText.value.text = homeController.contentData[1].content ?? '';
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const HeaderSearchBar(
              title: "Static Content",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Text(
                    'Terms and Conditions.',
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                                color: Colors.white, width: 0.56))),
                    onPressed: () async {
                      if (homeController.isEditTerms.value) {
                        homeController.addTermsAndPolicy(
                            termsText.value.text.trim(), "1");
                        homeController.isEditTerms.value = false;
                      } else {
                        homeController.isEditTerms.value = true;
                      }
                    },
                    child: Text(
                      homeController.isEditTerms.value ? "Save" : 'Edit',
                      style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: btnColor)),
              child: TextField(
                controller: termsText.value,
                readOnly: !homeController.isEditTerms.value,
                maxLines: 1000,
                style: const TextStyle(color: secondaryColor, fontSize: 15),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Text(
                    'Privacy Policy.',
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                  const Spacer(),
                  TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                  color: Colors.white, width: 0.56))),
                      onPressed: () async {
                        if (homeController.isEditPolicy.value) {
                          homeController.addTermsAndPolicy(
                              policyText.value.text.trim(), "2");
                          homeController.isEditPolicy.value = false;
                        } else {
                          homeController.isEditPolicy.value = true;
                        }
                      },
                      child: Text(
                        homeController.isEditPolicy.value ? "Save" : 'Edit',
                        style: const TextStyle(
                            color: secondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )),
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: btnColor)),
              child: TextField(
                controller: policyText.value,
                readOnly: !homeController.isEditPolicy.value,
                style: const TextStyle(color: secondaryColor, fontSize: 15),
                maxLines: 1000,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none),
              ),
            ))
          ],
        ),
      );
    });
  }
}
