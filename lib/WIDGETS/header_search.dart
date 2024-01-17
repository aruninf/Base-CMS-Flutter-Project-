import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CUSTOM_WIDGETS/common_button.dart';
import '../../UTILS/app_color.dart';

class HeaderSearchBar extends StatelessWidget {
  const HeaderSearchBar({super.key, this.title, this.onChanges, this.controller});

  final String? title;
  final Function()? onChanges;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: thirdColor.withOpacity(0.5)
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.black87),
        onEditingComplete: onChanges,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: thirdColor, width: 0.56),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: const BorderSide(color: Colors.white, width: 0.56),
          ),
          hintText: "Search",
          hintStyle: const TextStyle(color: Colors.black87),
          labelStyle: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
