import 'package:becomesecurecms/HOME/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/UTILS/app_color.dart';
import '../CONTROLERS/user_conntroller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_text_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_images.dart';
import '../WIDGETS/responsive.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailC = TextEditingController();
  final passC = TextEditingController();

  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return  Responsive(
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
                      CommonTextField(
                        hintText: 'Email',
                        controller: emailC,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: TextFormField(
                              controller: passC,
                              keyboardType: TextInputType.text,
                              obscureText: controller.isPasswordVisible.value,
                              maxLines: 1,
                              maxLength: 16,
                              cursorColor: secondaryColor,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  hintStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w600),
                                  hintText: 'Password',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.isPasswordVisible.value =
                                          !controller.isPasswordVisible.value;
                                    },
                                    child: Icon(
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: thirdColor,
                                    ),
                                  ))),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: Get.width,
                        height: 55,
                        child: CommonButton(
                          btnText: "Log In",
                          onClick: () async {

                            Get.to(HomePage());
                           /* if (emailC.text == '' ||
                                emailC.text.isEmpty ||
                                !emailC.text.contains('@') ||
                                !emailC.text.contains('.')) {
                              Get.snackbar(
                                  'Required!', 'Please enter the correct email',
                                  colorText: Colors.orange,
                                  snackPosition: SnackPosition.TOP);

                              return;
                            }

                            var data = {
                              "email": emailC.text.trim(),
                              "password": passC.text.trim()
                            };
                            await controller.adminLogin(data);*/
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => ForgotPasswordPage()),
                        child: const CustomText(
                          text: 'Forgot Password?',
                          color: secondaryColor,
                          sizeOfFont: 14,
                          weight: FontWeight.w700,
                        ),
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
