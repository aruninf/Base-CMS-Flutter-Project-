import '/CONTROLERS/fish_conntroller.dart';
import '/MODELS/category_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../UTILS/app_color.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({Key? key, this.callback, this.dropdownValue})
      : super(key: key);

  final void Function(String)? callback;
  final String? dropdownValue;

  @override
  _CategoryDropdownState createState() =>
      _CategoryDropdownState(callback: callback, dropdownValue: dropdownValue);
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  _CategoryDropdownState({this.callback, this.dropdownValue});

  String? dropdownValue;
  final void Function(String)? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width -
            (MediaQuery.of(context).size.width * 0.3),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: DropdownButton<dynamic>(
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              value: dropdownValue ??
                  Get.find<FishController>().categoryData[0].id.toString(),
              items: Get.find<FishController>()
                  .categoryData
                  .map((CategoryData item) {
                return DropdownMenuItem(
                    value: "${item.id}",
                    child: Text(
                      item.name ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ));
              }).toList(),
              onChanged: (v) {
                setState(() {
                  dropdownValue = v!;
                  callback!(v);
                });
              },
              underline: Container(),
            )));
  }
}
