import 'package:flutter/material.dart';

import '../../UTILS/app_color.dart';

class DashBoardTotalWidget extends StatelessWidget {
  const DashBoardTotalWidget(
      {super.key, required this.title, required this.value, this.isFilter});

  final String? title;
  final String? value;
  final bool? isFilter;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.8),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          Row(
            children: [
              Text(
                value ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Spacer(),
              const Padding(
                padding: EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Weekly",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: secondaryColor, fontSize: 14),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: secondaryColor,
                      size: 18,
                    )
                  ],
                ),
              ),
            ],
          )

        ],
      ),
    ));
  }
}
