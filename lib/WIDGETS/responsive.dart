import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';

class Responsive extends StatelessWidget {
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 576;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 576 &&
      MediaQuery.of(context).size.width <= 992;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 992;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width > 992) {
      return desktop;
    } else if (size.width >= 576) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Mobile View not supported',
            style: TextStyle(color: secondaryColor),
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text(
            'Mobile View not supported',
            style: TextStyle(color: secondaryColor),
          ),
        ),
      );
    }
  }
}
