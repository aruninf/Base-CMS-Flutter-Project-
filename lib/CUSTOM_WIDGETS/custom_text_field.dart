import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      this.controller,
      required this.hintText,
      this.maxLine,
      this.textInputType,
      this.onClick});

  final TextEditingController? controller;
  final int? maxLine;
  final String hintText;
  final TextInputType? textInputType;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(16.0),
          //border: Border.all(width: 1,color: btnColor)
        ),
        child: TextFormField(
            controller: controller,
            onTap: onClick,
            cursorColor: secondaryColor,
            keyboardType: textInputType ?? TextInputType.text,
            maxLines: maxLine ?? 1,
            style: const TextStyle(fontWeight: FontWeight.w600,color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                hintStyle:
                    const TextStyle(fontSize: 16,color: Colors.white70, fontWeight: FontWeight.w600),
                hintText: hintText)));
  }
}
