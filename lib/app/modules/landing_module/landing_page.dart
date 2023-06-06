import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:movie/app/routes/app_pages.dart';
import 'package:movie/app/themes/app_colors.dart';
import 'package:movie/app/themes/app_text_theme.dart';
import 'package:movie/app/utils/widgets/app_button/app_button.dart';
import '../../../app/modules/landing_module/landing_controller.dart';
import '../../utils/widgets/app_landing_scroll/custom_app_scroll_image.dart';

class LandingPage extends GetWidget<LandingController> {
  const LandingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: ShaderMask(
              blendMode: BlendMode.dstOut,
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.9),
                    Colors.black,
                  ],
                  stops: const [0, 0.62, 0.67, 0.85, 1],
                ).createShader(rect);
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    ImageListView(
                      startIndex: 1,
                      duration: 25,
                    ),
                    SizedBox(height: 10),
                    ImageListView(
                      startIndex: 11,
                      duration: 45,
                    ),
                    SizedBox(height: 10),
                    ImageListView(
                      startIndex: 4,
                      duration: 45,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 24,
            right: 24,
            child: Container(
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DelayedWidget(
                    delayDuration: Duration(milliseconds: 400),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Text(
                      'Flicks Unleashed',
                      style: AppTextStyles.base.w900.whiteColor.s20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  DelayedWidget(
                    delayDuration: Duration(milliseconds: 600),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: const Text(
                      'Explore uncharted cinematic territories & uncover hidden gems!',
                      style: TextStyle(
                        color: Colors.white70,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const Spacer(),
                  DelayedWidget(
                    delayDuration: Duration(milliseconds: 1000),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: AppButton(
                      onPressed: () {
                        if (controller.canVibrate.value) Vibrate.feedback(FeedbackType.success);
                        Get.offAllNamed(AppRoutes.base);
                      },
                      text: "Continue",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
