import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Created by Arun Android

class DialogHelper {
  //show error dialog
  static Future<void> showErrorDialog(
      {String title = 'Error',
      String? description = 'Something went wrong'}) async {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description ?? 'Something went wrong',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text(
                  'OKAY',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> showPermissionDialog(
      {String title = 'Permission',
      String? description =
          'You have permanently denied all permissions give permission in app setting'}) async {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.subtitle1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.subtitle2,
              ),
              TextButton(
                onPressed: () async {
                  if (Get.isDialogOpen!) Get.back();
                  //await openAppSettings();
                },
                child: const Text('Open Setting'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show loading
  static void showLoading([String? message]) {
    Get.dialog(Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const CircularProgressIndicator(),
      ),
    ));
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
