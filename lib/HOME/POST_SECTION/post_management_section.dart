import '/MODELS/post_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../CONTROLERS/home_conntroller.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../WIDGETS/header_search.dart';

class PostManagementSection extends StatefulWidget {
  PostManagementSection({super.key});

  @override
  State<PostManagementSection> createState() => _PostManagementSectionState();
}

class _PostManagementSectionState extends State<PostManagementSection> {
  final homeController = Get.find<HomeController>();
  final scrollController = ScrollController();
  var page = 1;

  @override
  void initState() {
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)) {
        setState(() {
          page += 1;
          //add api for load the more data according to new page
          Future.delayed(
            Duration.zero,
            () async {
              var data = {
                "sortBy": "desc",
                "sortOn": "created_at",
                "type":1,
                "page": page,
                "limit": 20,
              };
              homeController.getPostsData(data);
            },
          );
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: HeaderSearchBar(
            title: "Post Management",
          ),
        ),
        Expanded(
            child: Obx(() => homeController.postData.isNotEmpty
                ? GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 1350 ? 3 : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1),
                    itemCount: homeController.postData.length,
                    itemBuilder: (context, index) =>
                        PostItemRow(postData: homeController.postData[index]),
                  )
                : const Center(
                    child: Text(
                      'No Post Found!',
                      style: TextStyle(color: secondaryColor),
                    ),
                  )))
      ],
    );
  }
}

class PostItemRow extends StatelessWidget {
  PostItemRow({super.key, required this.postData});

  final PostData postData;
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white70, width: 1.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomText(
                text: "Status Of the Post",
                color: secondaryColor,
              ),
              const Spacer(),
              Switch(
                // activeColor: Colors.green,
                activeTrackColor: Colors.green,
                value: postData.status == 1,
                onChanged: (value) {
                  homeController.updatePost(value, postData.id.toString());
                },
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  postData.userHandle ?? '',
                  style: const TextStyle(
                      fontFamily: "Rodetta",
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: secondaryColor),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: Icon(
                      PhosphorIcons.map_pin,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: CustomText(
                      text: postData.address ?? '',
                      weight: FontWeight.w400,
                      sizeOfFont: 13,
                      maxLin: 1,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                postData.image ?? '',
                width: Get.width,
                height: MediaQuery.of(context).size.width > 1350
                    ? Get.width * 0.18
                    : Get.width * 0.30,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  fishingImage,
                  width: Get.width,
                  height: MediaQuery.of(context).size.width > 1350
                      ? Get.width * 0.18
                      : Get.width * 0.30,
                ),
              )),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    fishIcon,
                    height: 20,
                    width: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    PhosphorIcons.chat,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    PhosphorIcons.share_network,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    PhosphorIcons.bookmark_simple,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          CustomText(
            text: postData.caption ?? '',
            weight: FontWeight.w600,
            sizeOfFont: 14,
            maxLin: 2,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
