import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../themes/app_text_theme.dart';

class StatsContainer extends StatelessWidget {
  const StatsContainer({super.key, required this.popularity, required this.userScore, required this.upVotes});

  final double popularity;
  final double userScore;
  final double upVotes;

  @override
  Widget build(BuildContext context) {
    return DelayedWidget(
      animation: DelayedAnimations.SLIDE_FROM_LEFT,
      animationDuration: Duration(milliseconds: 1000),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Text(
                    "${popularity.roundToDouble()}",
                    style: AppTextStyles.base.whiteColor.s12,
                  ),
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      LucideIcons.barChart,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Popularity",
                      style: AppTextStyles.base.whiteColor.s12,
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 25.0,
                      lineWidth: 2.0,
                      animation: true,
                      percent: (upVotes / 10).clamp(0.0, 1.0),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.green,
                      center: Text(
                        "${upVotes.toStringAsFixed(2)}%",
                        style: AppTextStyles.base.whiteColor.s12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      LucideIcons.gauge,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "User Score",
                      style: AppTextStyles.base.whiteColor.s12,
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Text(
                    "${userScore.roundToDouble()}",
                    style: AppTextStyles.base.whiteColor.s12,
                  ),
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      LucideIcons.thumbsUp,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Upvotes",
                      style: AppTextStyles.base.whiteColor.s12,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
