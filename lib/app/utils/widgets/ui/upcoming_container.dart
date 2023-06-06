import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../themes/app_text_theme.dart';
import '../../constants.dart';

class UpcomingContainer extends StatefulWidget {
  const UpcomingContainer({super.key, this.list, this.controller, required this.isMovie, this.onClick});
  final dynamic list;
  final dynamic controller;
  final bool isMovie;
  final Function()? onClick;

  @override
  State<UpcomingContainer> createState() => _UpcomingContainerState();
}

class _UpcomingContainerState extends State<UpcomingContainer> {
  var canVibrate = false.obs;
  initVibrate() async {
    canVibrate.value = await Vibrate.canVibrate;
  }

  @override
  void initState() {
    initVibrate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: Get.width,
      child: ListView.builder(
        cacheExtent: 999999,
        itemCount: widget.list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          final imageUrl = widget.list[index].posterPath != null ? "${EndPoints.tmdbImageUrl}${widget.list[index].posterPath}" : EndPoints.dummyImageUrl;
          return InkWell(
            onTap: () {
              if (canVibrate.value) Vibrate.feedback(FeedbackType.success);
              widget.onClick ?? widget.controller.goToDetails(id: widget.list[index].id.toString(), showKind: widget.isMovie ? "movie" : "tv", initialImage: imageUrl);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    width: 200,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      memCacheHeight: 781,
                      memCacheWidth: 550,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (widget.isMovie ? widget.list[index].title : widget.list[index].name) ?? 'No title or name available',
                              style: AppTextStyles.base.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
