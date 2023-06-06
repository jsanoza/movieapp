import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:movie/app/modules/chat_module/chat_controller.dart';
import '../../../app/modules/seriesdetails_module/seriesdetails_controller.dart';
import '../../data/provider/chat_provider.dart';
import '../../routes/app_pages.dart';
import '../../themes/app_text_theme.dart';
import '../../utils/constants.dart';
import '../../utils/widgets/app_divider/app_divider.dart';
import '../../utils/widgets/ui/genre_container.dart';
import '../../utils/widgets/ui/notice.dart';
import '../../utils/widgets/ui/shimmer_container.dart';
import '../../utils/widgets/ui/stack_buttons_container.dart';
import '../../utils/widgets/ui/stats_container.dart';
import '../../utils/widgets/ui/upcoming_container.dart';
import '../../utils/widgets/ui/videos_container.dart';

class SeriesDetailsPage extends GetWidget<SeriesDetailsController> {
  const SeriesDetailsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Get.delete<SeriesDetailsController>();
          return Future(() => true);
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          floatingActionButton: Obx(() => controller.isNetwork.value == true
              ? FloatingActionButton(
                  onPressed: () {
                    if (controller.canVibrate.value) Vibrate.feedback(FeedbackType.success);
                    final imageUrl = controller.seriesDetails.first.posterPath != null ? "${EndPoints.tmdbImageUrl}${controller.seriesDetails.first.posterPath}" : EndPoints.dummyImageUrl;
                    Get.put(ChatController(provider: ChatProvider()));
                    Get.find<ChatController>().headerImageurl.value = imageUrl;
                    Get.find<ChatController>().overview.value = controller.seriesDetails.first.overview!;
                    Get.find<ChatController>().titleOrName.value = controller.seriesDetails.first.name!;
                    Get.find<ChatController>().releaseYear.value = controller.seriesDetails.first.firstAirDate!;
                    Get.toNamed(AppRoutes.chat);
                  },
                  child: Icon(LucideIcons.bot),
                )
              : SizedBox.shrink()),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.black,
                automaticallyImplyLeading: true,
                expandedHeight: Get.height / 2,
                stretch: true,
                snap: false,
                floating: false,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  controller.updateTop(constraints.biggest.height);
                  return FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(bottom: 16, left: 10),
                    title: controller.top.value < 110.14
                        ? Row(
                            children: [
                              InkWell(
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  Get.back();
                                  Get.delete<SeriesDetailsController>();
                                },
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              AutoSizeText(
                                controller.seriesDetails.first.name.toString(),
                                style: AppTextStyles.base.whiteColor.s14,
                                maxLines: 2,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DelayedWidget(
                                animation: DelayedAnimations.SLIDE_FROM_TOP,
                                animationDuration: Duration(milliseconds: 1500),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4.0, right: 14),
                                        child: Obx(() => controller.isLoaded.value == true
                                            ? AutoSizeText(
                                                controller.seriesDetails.first.name.toString(),
                                                style: AppTextStyles.base.whiteColor.s24,
                                                maxLines: 2,
                                              )
                                            : SizedBox.shrink()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Obx(() => controller.isLoaded.value == true
                                  ? DelayedWidget(
                                      animation: DelayedAnimations.SLIDE_FROM_LEFT,
                                      animationDuration: Duration(milliseconds: 1000),
                                      child: Obx(
                                        () => Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 4.0, right: 4, top: 8),
                                                child: Text(
                                                  controller.seriesDetails.first.tagline!,
                                                  style: AppTextStyles.base.whiteColor.s10.italic,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink()),
                            ],
                          ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          foregroundDecoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0, 0.8],
                            ),
                          ),
                          child: Hero(
                            tag: controller.headerImageurl,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.headerImageurl.toString(),
                              memCacheHeight: 1942,
                              memCacheWidth: 1031,
                            ),
                          ),
                        ),
                        Obx(() => controller.isNetwork == true
                            ? Positioned.fill(
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: StackButtonContainer(
                                      linkTap: () {
                                        if (controller.canVibrate.value) Vibrate.feedback(FeedbackType.success);
                                        controller.openLink(url: controller.seriesDetails.first.homepage.toString());
                                      },
                                      videoTap: () {
                                        if (controller.canVibrate.value) Vibrate.feedback(FeedbackType.success);
                                        controller.viewVideos(videoModel: controller.videoModel.first);
                                      },
                                    )),
                              )
                            : SizedBox.shrink())
                      ],
                    ),
                  );
                }),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Obx(
                    () => controller.isNetwork.value == true
                        ? Column(
                            children: [
                              Obx(() => controller.isLoaded.value == true
                                  ? GenreContainer(
                                      list: controller.seriesDetails,
                                    )
                                  : SizedBox.shrink()),
                              SizedBox(
                                height: 20,
                              ),
                              Obx(
                                () => controller.isLoaded.value == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: AppDivider(
                                          height: 2,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                              Obx(() => controller.isLoaded.value == true
                                  ? StatsContainer(
                                      popularity: controller.seriesDetails.first.popularity!.toDouble(),
                                      upVotes: controller.seriesDetails.first.voteAverage!.toDouble(),
                                      userScore: controller.seriesDetails.first.voteCount!.toDouble(),
                                    )
                                  : SizedBox.shrink()),
                              Obx(
                                () => controller.isLoaded.value == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: AppDivider(
                                          height: 2,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                              Obx(() => controller.isLoaded.value == true
                                  ? DelayedWidget(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 16),
                                            child: Text(
                                              "Overview",
                                              style: AppTextStyles.base.whiteColor.s24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink()),
                              Obx(() => controller.isLoaded.value == true
                                  ? DelayedWidget(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16.0, right: 16),
                                            child: Text(
                                              controller.seriesDetails.first.overview!,
                                              style: AppTextStyles.base.whiteColor.s14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink()),
                              Obx(
                                () => controller.isLoaded.value == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: AppDivider(
                                          height: 2,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                              Obx(() => controller.isLoaded.value == true
                                  ? DelayedWidget(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                                            child: Text(
                                              "Seasons",
                                              style: AppTextStyles.base.whiteColor.s24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink()),
                              Obx(() => controller.isLoaded.value == true
                                  ? DelayedWidget(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: Get.width,
                                          child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: controller.seriesSeasons.length,
                                            itemBuilder: (context, index) {
                                              final season = controller.seriesSeasons[index];
                                              return ExpansionTile(
                                                leading: Container(
                                                  height: 100,
                                                  width: 40,
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.contain,
                                                    imageUrl: season.posterPath != null ? "${EndPoints.tmdbImageUrl}${season.posterPath}" : EndPoints.dummyImageUrl,
                                                  ),
                                                ),
                                                title: Text(
                                                  season.name!,
                                                  style: AppTextStyles.base.whiteColor.s16,
                                                ),
                                                subtitle: Text(
                                                  "Total Episodes: ${season.episodeCount!.toString()}",
                                                  style: AppTextStyles.base.whiteColor.s12,
                                                ),
                                                trailing: Icon(
                                                  LucideIcons.chevronDown,
                                                  color: Colors.white,
                                                ),
                                                onExpansionChanged: (expanded) {
                                                  controller.toggleExpansion(index, season.seasonNumber!);
                                                },
                                                children: [
                                                  Obx(() => controller.isSeasonDataLoaded.value == true
                                                      ? Padding(
                                                          padding: const EdgeInsets.only(top: 10.0),
                                                          child: Container(
                                                              height: 300,
                                                              width: Get.width,
                                                              child: ListView.builder(
                                                                itemCount: controller.seasonDetails.first.episodes!.length,
                                                                itemBuilder: ((context, index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: ListTile(
                                                                      leading: Container(
                                                                        height: 300,
                                                                        width: 100,
                                                                        child: CachedNetworkImage(
                                                                          fit: BoxFit.contain,
                                                                          imageUrl: controller.seasonDetails.first.episodes![index].stillPath != null ? "${EndPoints.tmdbImageUrl}${controller.seasonDetails.first.episodes![index].stillPath}" : EndPoints.dummyImageUrl,
                                                                        ),
                                                                      ),
                                                                      title: Text(
                                                                        "${controller.seasonDetails.first.episodes![index].episodeNumber} ● ${controller.seasonDetails.first.episodes![index].name!}",
                                                                        style: AppTextStyles.base.whiteColor,
                                                                      ),
                                                                      subtitle: Text(
                                                                        controller.seasonDetails.first.episodes![index].overview!,
                                                                        style: AppTextStyles.base.whiteColor,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                              )),
                                                        )
                                                      : SizedBox.shrink()),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container()),
                              Obx(
                                () => controller.isLoaded.value == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: AppDivider(
                                          height: 2,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                              Obx(() => controller.isLoaded.value == true
                                  ? DelayedWidget(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                                            child: Text(
                                              "Videos",
                                              style: AppTextStyles.base.whiteColor.s24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink()),
                              Obx(() => controller.isLoaded.value == true
                                  ? DelayedWidget(
                                      child: Obx(
                                        () => controller.isVideosLoaded.value == true
                                            ? VideoContainer(
                                                videoList: controller.videoModel,
                                                onClick: (index) {
                                                   if (controller.canVibrate.value) Vibrate.feedback(FeedbackType.success);
                                                  controller.viewVideos(videoModel: controller.videoModel[index]);
                                                },
                                              )
                                            : Container(
                                                height: 190,
                                                width: Get.width,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: 2,
                                                  itemBuilder: ((context, index) {
                                                    return ShimmerContainer(
                                                      height: 200,
                                                      width: 300,
                                                    );
                                                  }),
                                                ),
                                              ),
                                      ),
                                    )
                                  : SizedBox.shrink()),
                              Obx(
                                () => controller.isLoaded.value == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: AppDivider(
                                          height: 2,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                              Obx(() => controller.isLoaded.value == true
                                  ? DelayedWidget(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                                            child: Text(
                                              "Similar",
                                              style: AppTextStyles.base.whiteColor.s24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink()),
                              Obx(() => controller.isLoaded.value == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: UpcomingContainer(
                                        isMovie: false,
                                        list: controller.similarSerieses,
                                        controller: controller,
                                        onClick: () {
                                          print("hi");
                                        },
                                      ),
                                    )
                                  : SizedBox.shrink()),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          )
                        : Notice(),
                  )
                ]),
              ),
            ],
          ),
        ));
  }
}
