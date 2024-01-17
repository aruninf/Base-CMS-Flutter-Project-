import '/CONTROLERS/user_conntroller.dart';
import '/CUSTOM_WIDGETS/common_button.dart';
import '/UTILS/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/consts.dart';
import '../../WIDGETS/header_search.dart';

class InboxSection extends StatelessWidget {
  InboxSection({super.key});

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
            title: 'Inbox',
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: btnColor, width: 1),
                            borderRadius: BorderRadius.circular(16)),
                        child: controller.inboxData.isNotEmpty
                            ? ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  thickness: 0.56,
                                ),
                                padding: const EdgeInsets.all(16),
                                itemCount: controller.inboxData.length,
                                itemBuilder: (context, index) => ListTile(
                                  onTap: () async {
                                    controller.selectedInboxData.value =
                                        controller.inboxData[index];
                                  },
                                  title: Text(
                                    controller.inboxData[index].name ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: controller
                                                    .inboxData[index].status ==
                                                0
                                            ? fishColor
                                            : btnColor,
                                        fontWeight: controller
                                                    .inboxData[index].status ==
                                                0
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  subtitle: Text(
                                    controller.inboxData[index].comments ?? '',
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: controller
                                                    .inboxData[index].status ==
                                                0
                                            ? secondaryColor
                                            : btnColor,
                                        fontWeight: controller
                                                    .inboxData[index].status ==
                                                0
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  trailing: CustomText(
                                    text: formatDateTimeToMMM(
                                        controller.inboxData[index].createdAt ??
                                            ''),
                                    color: btnColor,
                                  ),
                                ),
                              )
                            : const Center(
                                child: Text("No Message yet!"),
                              ),
                      )),
                ),
                Expanded(
                    child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            controller.selectedInboxData.value.name ?? '',
                            style: TextStyle(
                                color:
                                    controller.selectedInboxData.value.status ==
                                            0
                                        ? fishColor
                                        : btnColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 17),
                          ),
                          subtitle: Text(
                            controller.selectedInboxData.value.comments ?? '',
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                color: btnColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          trailing: controller.selectedInboxData.value.status ==
                                  0
                              ? CommonButton(
                                  btnBgColor: secondaryColor,
                                  btnTextColor: primaryColor,
                                  btnText: 'Mark as read',
                                  onClick: () async {
                                    var param = {
                                      "id":
                                          controller.selectedInboxData.value.id,
                                      "status": true
                                    };
                                    controller.updateInbox(param);
                                  },
                                )
                              : const SizedBox.shrink(),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
