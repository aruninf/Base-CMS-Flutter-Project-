import '/CUSTOM_WIDGETS/common_button.dart';
import '/CUSTOM_WIDGETS/custom_text_field.dart';
import '/UTILS/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CONTROLERS/fish_conntroller.dart';
import '../../UTILS/consts.dart';
import '../../WIDGETS/responsive.dart';
import '../../WIDGETS/header_search.dart';

class BroadcastSection extends StatelessWidget {
  BroadcastSection({super.key});

  final controller = Get.find<FishController>();

  final title = TextEditingController().obs;
  final message = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.2, vertical: Get.width * .01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16,),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Send notification to everyone ',
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                ' ( All users will receive a notification whenever app is close or open )',
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: 13),
              ),
              // const Spacer(),
              // Obx(() => Switch(
              //       value: controller.isEveryone.value,
              //       onChanged: (value) {
              //         controller.isEveryone.value =
              //             !controller.isEveryone.value;
              //       },
              //     ))
            ],
          ),
          SizedBox(height: 16,),
          CommonTextField(
            hintText: 'Title',
            controller: title.value,
          ),
          const SizedBox(
            height: 16,
          ),
          CommonTextField(
            hintText: 'Message',
            controller: message.value,
            maxLine: 10,
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: CommonButton(
                btnBgColor: secondaryColor,
                btnTextColor: fishColor,
                btnText: 'Send',
                onClick: () async {
                  var data = {
                    "send_to_everyone": controller.isEveryone.value,
                    "location": "Sydney",
                    "age": "20",
                    "gender": title.value.text,
                    "message": message.value.text
                  };
                  controller.broadcast(data);
                  title.value.text = "";
                  message.value.text = "";
                },
              ))
        ],
      ),
    );
  }
}
