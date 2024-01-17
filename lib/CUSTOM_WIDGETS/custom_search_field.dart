import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.controller,
    required this.hintText,
  });

  final TextEditingController? controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 5.0,
                color: Colors.black26,
              ),
            ]),
        child: TextFormField(
            keyboardType: TextInputType.text,
            maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                hintStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                hintText: hintText)));
  }
}
