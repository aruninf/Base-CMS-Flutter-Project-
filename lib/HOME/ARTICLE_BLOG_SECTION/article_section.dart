import '/CONTROLERS/user_conntroller.dart';
import '/CUSTOM_WIDGETS/custom_text_field.dart';
import '/MODELS/article_response.dart';
import '/MODELS/blog_response.dart';
import '/WIDGETS/cancel_done_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../WIDGETS/header_search.dart';

class ArticleSection extends StatelessWidget {
  ArticleSection({super.key});

  final controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSearchBar(
                title: "Article & Blog Management",
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        controller.isArticleView.value = true;
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: controller.isArticleView.value
                            ? fishColor
                            : primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(width: 1, color: fishColor)),
                      ),
                      child: const Text(
                        'Articles',
                        style: TextStyle(
                            color: secondaryColor, fontWeight: FontWeight.w700),
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  TextButton(
                      onPressed: () async {
                        controller.isArticleView.value = false;
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: controller.isArticleView.value
                            ? primaryColor
                            : fishColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(width: 1, color: fishColor)),
                      ),
                      child: const Text(
                        'Blogs',
                        style: TextStyle(
                            color: secondaryColor, fontWeight: FontWeight.w700),
                      )),
                  const Spacer(),
                  controller.isArticleView.value
                      ? TextButton(
                          onPressed: () async {
                            Get.dialog(
                                barrierDismissible: true,
                                Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: AddArticleOrBlogWidget(
                                    isArticle: true,
                                    //userData: userData,
                                  ),
                                ));
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: fishColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                    width: 1, color: fishColor)),
                          ),
                          child: const Text(
                            'Add Article',
                            style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w700),
                          ))
                      : TextButton(
                          onPressed: () async {
                            Get.dialog(
                                barrierDismissible: true,
                                Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: AddArticleOrBlogWidget(
                                    isArticle: false,
                                    //userData: userData,
                                  ),
                                ));
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: fishColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                    width: 1, color: fishColor)),
                          ),
                          child: const Text(
                            'Add Blog',
                            style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w700),
                          )),
                ],
              ),
              controller.isArticleView.value
                  ? ArticleListWidget()
                  : BlogListWidget()
            ],
          )),
    );
  }
}

class AddArticleOrBlogWidget extends StatelessWidget {
  AddArticleOrBlogWidget(
      {super.key, required this.isArticle, this.blogData, this.articleData});

  final controller = Get.find<UserController>();
  final titleController = TextEditingController().obs;
  final subTitleController = TextEditingController().obs;
  final textController = TextEditingController().obs;
  final ArticleData? articleData;
  final BlogData? blogData;
  final bool isArticle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 3,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: primaryColor,
          border: Border.all(color: fishColor, width: 1),
          borderRadius: BorderRadius.circular(16)),
      child: Obx(() {
        Get.find<UserController>().uploadImageUrl.value =
            isArticle ? articleData?.image ?? '' : blogData?.image ?? '';
        titleController.value.text =
            isArticle ? articleData?.title ?? '' : blogData?.heading ?? '';
        textController.value.text = isArticle
            ? articleData?.article ?? ''
            : blogData?.description ?? '';
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () async {
                await Get.find<UserController>().getImage();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(
                  Get.find<UserController>().uploadImage.value,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    fishingImage,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const CustomText(
              text: "Select An Image",
              color: secondaryColor,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              hintText: "Title",
              controller: titleController.value,
            ),
            const SizedBox(
              height: 16,
            ),
            isArticle
                ? const SizedBox.shrink()
                : CommonTextField(
                    hintText: "Sub Heading",
                    controller: subTitleController.value,
                  ),
            isArticle
                ? const SizedBox.shrink()
                : const SizedBox(
                    height: 16,
                  ),
            CommonTextField(
              hintText: "Add Text here...",
              controller: textController.value,
              maxLine: 10,
            ),
            const SizedBox(
              height: 16,
            ),
            CommonCancelAndCreateButton(
              submit: () {
                if (Get.find<UserController>().uploadImageUrl.value.length <
                    3) {
                  Get.snackbar('Required!', 'Please select image',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }

                if (titleController.value.text.length < 3) {
                  Get.snackbar('Required!', 'Please enter the correct title',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }
                if (textController.value.text.length < 3) {
                  Get.snackbar('Required!', 'Please enter the correct text',
                      colorText: Colors.orange,
                      snackPosition: SnackPosition.TOP);
                  return;
                }

                var data = {
                  "id": isArticle ? articleData?.id : blogData?.id,
                  "title": titleController.value.text.trim(),
                  "image": Get.find<UserController>().uploadImageUrl.value,
                  "article": textController.value.text.trim(),
                };

                var data1 = {
                  "id": isArticle ? articleData?.id : blogData?.id,
                  "heading": titleController.value.text.trim(),
                  "image": Get.find<UserController>().uploadImageUrl.value,
                  "sub_heading": subTitleController.value.text.trim(),
                  "description": textController.value.text.trim(),
                };
                if (isArticle) {
                  controller.addArticleOrBlog(
                      data, true, (articleData?.article ?? '').isNotEmpty);
                } else {
                  controller.addArticleOrBlog(
                      data1, false, (blogData?.heading ?? '').isNotEmpty);
                }
                Get.back();
              },
              btnText: "Post",
            ),
          ],
        );
      }),
    );
  }
}

class ArticleListWidget extends StatelessWidget {
  ArticleListWidget({super.key});

  final controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: controller.articleData.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 0.56,
                  ),
                  itemCount: controller.articleData.length,
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "${controller.articleData[index].image}",
                        fit: BoxFit.cover,
                        height: 120,
                        width: 120,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(fishingImage,
                                height: 80, width: 120, fit: BoxFit.cover),
                      ),
                    ),
                    title: CustomText(
                      text: "${controller.articleData[index].title}",
                      color: fishColor,
                      sizeOfFont: 18,
                      weight: FontWeight.w700,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CustomText(
                        text: "${controller.articleData[index].article}",
                        color: btnColor,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 30,
                          child: TextButton(
                              onPressed: () async {
                                Get.dialog(
                                    barrierDismissible: true,
                                    Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: AddArticleOrBlogWidget(
                                        isArticle: true,
                                        articleData:
                                            controller.articleData[index],
                                        blogData: controller.blogData[index],
                                      ),
                                    ));
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  side: const BorderSide(
                                      width: 0.56, color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          height: 30,
                          child: TextButton(
                              onPressed: () async {
                                var data = {
                                  "id":
                                      '${controller.articleData[index].id ?? 0}'
                                };
                                controller.deleteArticle(data, true);
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: fishColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          width: 0.56, color: Colors.white))),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    'No Record Found!',
                    style: TextStyle(color: secondaryColor),
                  ),
                ),
        ));
  }
}

class BlogListWidget extends StatelessWidget {
  BlogListWidget({super.key});
  final controller = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: controller.blogData.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 0.56,
                  ),
                  itemCount: controller.blogData.length,
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "${controller.blogData[index].image}",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          fishingImage,
                          height: 80,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: CustomText(
                      text: "${controller.blogData[index].heading}",
                      color: fishColor,
                      sizeOfFont: 18,
                      weight: FontWeight.w700,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CustomText(
                        text: "${controller.blogData[index].description}",
                        color: btnColor,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 30,
                          child: TextButton(
                              onPressed: () async {
                                Get.dialog(
                                    barrierDismissible: true,
                                    Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: AddArticleOrBlogWidget(
                                        isArticle: false,
                                        articleData:
                                            controller.articleData[index],
                                        blogData: controller.blogData[index],
                                      ),
                                    ));
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  side: const BorderSide(
                                      width: 0.56, color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          height: 30,
                          child: TextButton(
                              onPressed: () async {
                                var data = {
                                  "id": '${controller.blogData[index].id ?? 0}'
                                };
                                controller.deleteArticle(data, false);
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: fishColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          width: 0.56, color: Colors.white))),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    'No Record Found!',
                    style: TextStyle(color: secondaryColor),
                  ),
                ),
        ));
  }
}
