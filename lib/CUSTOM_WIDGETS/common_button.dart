import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      this.btnBgColor,
      this.btnTextColor,
      required this.btnText,
      required this.onClick});

  final Color? btnBgColor;
  final Color? btnTextColor;
  final String btnText;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: btnBgColor ?? btnColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14))),
        onPressed: onClick,
        child: Text(btnText.toUpperCase(),
            maxLines: 1,
            style: TextStyle(
                color: btnTextColor ?? Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 18)));
  }
}
