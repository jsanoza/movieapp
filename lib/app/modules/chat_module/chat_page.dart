import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../app/modules/chat_module/chat_controller.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_theme.dart';
import '../../utils/loading.dart';

class ChatPage extends GetWidget<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.delete<ChatController>();
        return Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
              Get.delete<ChatController>();
            },
            icon: Icon(
              LucideIcons.chevronLeft,
              color: Colors.white,
              size: 30,
            ),
          ),
          title: Text(
            "Chat GPT",
            style: AppTextStyles.base.whiteColor,
          ),
        ),
        backgroundColor: Colors.black,
        bottomNavigationBar: Container(
          height: 60,
          width: Get.width,
          // color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.questions.length,
              itemBuilder: ((context, index) {
                return Container(
                  height: 20,
                  child: SearchTypes(
                    name: controller.questions[index],
                    onTap: () {
                      if (controller.canVibrate.value) Vibrate.feedback(FeedbackType.success);
                      controller.sendChat(controller.questions[index]);
                    },
                  ),
                );
              }),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: Get.width,
                // color: Colors.red,
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.only(left: 0.0, right: 16, top: 16, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: controller.headerImageurl.value,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.titleOrName.value.toString(),
                              style: AppTextStyles.base.whiteColor.s18,
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              controller.overview.value.toString(),
                              style: AppTextStyles.base.whiteColor.s12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 4, top: 16),
                        child: Icon(
                          LucideIcons.bot,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 16, top: 16),
                        child: Text(
                          "Ask me anything!",
                          style: AppTextStyles.base.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(
                      () => controller.isSubmitted.value == true
                          ? Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Obx(
                                    () => AnimatedTextKit(
                                      animatedTexts: [
                                        TypewriterAnimatedText(
                                          controller.answer.value != "" ? controller.answer.value : "",
                                          textStyle: AppTextStyles.base.whiteColor.s12,
                                          speed: const Duration(milliseconds: 30),
                                        ),
                                      ],
                                      totalRepeatCount: 1,
                                      // pause: const Duration(milliseconds: 300),
                                      displayFullTextOnTap: true,
                                      stopPauseOnTap: true,
                                    ),
                                  )),
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTypes extends StatelessWidget {
  const SearchTypes({
    super.key,
    required this.onTap,
    required this.name,
  });
  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          onTap();
          log("Hey im here");
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.gray,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(name, style: AppTextStyles.base.w400.s14.whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
