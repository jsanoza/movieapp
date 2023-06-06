import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../themes/app_text_theme.dart';
import '../../constants.dart';

class TrendingContainer extends StatefulWidget {
  const TrendingContainer({super.key, required this.list, required this.controller, required this.isMovie});

  final dynamic list;
  final dynamic controller;
  final bool isMovie;

  @override
  State<TrendingContainer> createState() => _TrendingContainerState();
}

class _TrendingContainerState extends State<TrendingContainer> {
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
              widget.controller.goToDetails(id: widget.list[index].id.toString(), showKind: widget.isMovie ? "movie" : "tv", initialImage: imageUrl);
              // controller.getMovieDetailsByTitle(title: controller.tvShowsList[index].name.toString(), year: "2023");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    width: 200,
                    foregroundDecoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0, 0.5],
                      ),
                    ),
                    child: Hero(
                      tag: imageUrl.toString(),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        memCacheHeight: 781,
                        memCacheWidth: 550,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
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
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularPercentIndicator(
                                    radius: 25.0,
                                    lineWidth: 2.0,
                                    animation: true,
                                    percent: (widget.list[index].voteAverage! / 10).clamp(0.0, 1.0),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Colors.green,
                                    center: Text(
                                      "${widget.list[index].voteAverage!.toStringAsFixed(2)}%",
                                      style: AppTextStyles.base.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    style: AppTextStyles.base.whiteColor,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "#${(index + 1).toString()}",
                                      style: AppTextStyles.base.whiteColor,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
