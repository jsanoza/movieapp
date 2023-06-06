import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_text_theme.dart';

class GenreContainer extends StatelessWidget {
  const GenreContainer({super.key, required this.list});

  final dynamic list;
  
  @override
  Widget build(BuildContext context) {
    return DelayedWidget(
      animation: DelayedAnimations.SLIDE_FROM_RIGHT,
      animationDuration: Duration(milliseconds: 1000),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Container(
          height: 40,
          width: Get.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.first.genres!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {},
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
                        child: Text(list.first.genres![index].name!, style: AppTextStyles.base.w400.s14.whiteColor),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
