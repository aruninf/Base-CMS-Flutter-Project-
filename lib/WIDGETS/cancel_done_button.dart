import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../UTILS/app_color.dart';

class CommonCancelAndCreateButton extends StatelessWidget {
  const CommonCancelAndCreateButton(
      {super.key, required this.submit, this.btnText});

  final VoidCallback submit;
  final String? btnText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  side: const BorderSide(width: 0.56, color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              )),
        ),
        const SizedBox(
          width: 16,
        ),
        Flexible(
          fit: FlexFit.tight,
          child: TextButton(
              onPressed: submit,
              style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: fishColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side:
                          const BorderSide(width: 0.56, color: Colors.white))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  btnText ?? "Save",
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              )),
        ),
      ],
    );
  }
}
