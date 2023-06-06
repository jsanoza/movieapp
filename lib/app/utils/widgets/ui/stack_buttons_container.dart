import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StackButtonContainer extends StatelessWidget {
  const StackButtonContainer({super.key, required this.linkTap, required this.videoTap});

  final Function() linkTap;
  final Function() videoTap;

  @override
  Widget build(BuildContext context) {
    return DelayedWidget(
      animation: DelayedAnimations.SLIDE_FROM_RIGHT,
      animationDuration: Duration(milliseconds: 300),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  // controller.openLink(url: controller.movieDetails.first.homepage.toString());
                  linkTap();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                  child: Icon(
                    LucideIcons.link,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16),
              child: InkWell(
                onTap: () {
                  videoTap();
                  // controller.viewVideos(videoModel: controller.videoModel.first);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                  child: Icon(
                    LucideIcons.play,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
