import '/UTILS/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../../MODELS/user_response.dart';
import '../../../UTILS/app_color.dart';

class ShowUserInfoWidget extends StatelessWidget {
  const ShowUserInfoWidget({super.key, required this.userData});

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: primaryColor,
          border: Border.all(color: fishColor, width: 1),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  style: IconButton.styleFrom(backgroundColor: Colors.white38),
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.close,
                    color: fishColor,
                    size: 24,
                  ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.width * 0.07,
                width: Get.width * 0.07,
                child: ClipOval(
                  child: Image.network(
                    userData.profilePic ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      fishingImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData.name ?? '',
                    style: const TextStyle(
                        color: secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Introduction',
                    style: TextStyle(
                        color: fishColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width * 0.15,
                            child: Text(
                              userData.email ?? '',
                              style: const TextStyle(
                                  color: btnColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            userData.phoneNumber ?? '',
                            style: const TextStyle(
                                color: btnColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        width: 1,
                        color: fishColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData.dob ?? '',
                            style: const TextStyle(
                                color: btnColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            userData.gender ?? '',
                            style: const TextStyle(
                                color: btnColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        width: 1,
                        color: fishColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Posts',
                            style: TextStyle(
                                color: btnColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${userData.totalPosts ?? 0}',
                            style: const TextStyle(
                                color: btnColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Their Categories',
                      style: TextStyle(
                          color: secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      children: List.generate(
                          (userData.fishCatId ?? []).length,
                          (index) => Container(
                                margin: const EdgeInsets.only(top: 8, left: 5),
                                decoration: BoxDecoration(
                                  color: btnColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 12),
                                    child: CustomText(
                                      text: (userData.fishCatId ?? [])[index],
                                      sizeOfFont: 16,
                                      weight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              )),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Top Spots',
                      style: TextStyle(
                          color: secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      children: List.generate(
                          (userData.locationId ?? []).length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: secondaryColor,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      (userData.locationId ?? [])[index] ?? '',
                                      style: const TextStyle(
                                          color: btnColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              )),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
