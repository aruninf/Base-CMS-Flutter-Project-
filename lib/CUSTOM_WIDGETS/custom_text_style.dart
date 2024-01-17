import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      this.color,
      this.sizeOfFont,
      this.weight,
      this.maxLin,
      required this.text});

  final String text;
  final FontWeight? weight;
  final double? sizeOfFont;
  final Color? color;
  final int? maxLin;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLin ?? 100,
      style: TextStyle(
          fontWeight: weight ?? FontWeight.w500,
          fontSize: sizeOfFont ?? 14,
          color: color ?? Colors.black87),
    );
  }
}
