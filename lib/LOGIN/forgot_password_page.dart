import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/UTILS/app_color.dart';
import '../CONTROLERS/user_conntroller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_images.dart';
import '../WIDGETS/responsive.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final controller = Get.put(UserController());
  final emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: Scaffold(
        backgroundColor: primaryColor,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              fishTextImage,
              height: Get.width / 4,
              width: Get.width / 4,
            ),
            const SizedBox(
              width: 16,
            ),
            SizedBox(
              width: Get.width / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    text:
                        'Enter Your Registered email address we will send you a password reset link on this email address.',
                    color: secondaryColor,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    hintText: 'Email',
                    controller: emailC,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: Get.width,
                    height: 55,
                    child: CommonButton(
                      btnText: "Confirm",
                      onClick: () {
                        if (emailC.text == '' ||
                            emailC.text.isEmpty ||
                            !emailC.text.contains('@') ||
                            !emailC.text.contains('.')) {
                          Get.snackbar(
                              'Required!', 'Please enter the correct email',
                              colorText: Colors.orange,
                              snackPosition: SnackPosition.TOP);

                          return;
                        }
                        controller.forgotPassword(emailC.text.trim());
                        emailC.text = '';
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
