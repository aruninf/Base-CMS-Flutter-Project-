import '/UTILS/app_color.dart';
import '/UTILS/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CONTROLERS/home_conntroller.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key? key, required this.click}) : super(key: key);
  final Function(int i) click;
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0,

      width: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              'images/appLogo.png',
              height: 75,
              width: 75,
              color: btnColor,
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: homeController.listOfMenu.length,
                  itemBuilder: (context, index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          click(index);
                          homeController.selectedIndex.value = index;
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: homeController.selectedIndex.value ==
                                          index
                                      ? thirdColor
                                      : Colors.black87,
                                  width: 0.67)),
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            homeController.listOfMenu[index],
                            height: 24,
                            width: 24,
                            color: homeController.selectedIndex.value == index
                                ? thirdColor
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
