import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:movie/app/modules/home_module/home_controller.dart';
import '../../../app/modules/base_module/base_controller.dart';
import '../../themes/app_text_theme.dart';
import '../../utils/constants.dart';
import '../home_module/home_page.dart';

import '../home_module/series_page.dart';

class BasePage extends GetWidget<BaseController> {
  const BasePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      backgroundColor: Colors.black,
                      automaticallyImplyLeading: false,
                      expandedHeight: Get.height / 2,
                      pinned: true,
                      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                        controller.updateTop(constraints.biggest.height);
                        return FlexibleSpaceBar(
                          titlePadding: EdgeInsets.only(bottom: 0, left: 10),
                          title: controller.top.value < 110.14
                              ? TabBar(
                                  onTap: (value) {
                                    if (controller.canVibrate.value) Vibrate.feedback(FeedbackType.success);
                                    controller.changeCover(value);
                                  },
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelStyle: AppTextStyles.base.whiteColor.s14,
                                  tabs: [
                                      Tab(
                                        text: "Movies",
                                      ),
                                      Tab(
                                        text: "Series",
                                      ),
                                    ])
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    DelayedWidget(
                                      animation: DelayedAnimations.SLIDE_FROM_LEFT,
                                      animationDuration: Duration(milliseconds: 600),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Flicks Unleashed",
                                            style: AppTextStyles.base.whiteColor.s18,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    DelayedWidget(
                                      animation: DelayedAnimations.SLIDE_FROM_LEFT,
                                      animationDuration: Duration(milliseconds: 600),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Explore uncharted cinematic territories & uncover hidden gems!",
                                              style: AppTextStyles.base.whiteColor.s10,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    DelayedWidget(
                                      animation: DelayedAnimations.SLIDE_FROM_LEFT,
                                      animationDuration: Duration(milliseconds: 600),
                                      child: TabBar(
                                          onTap: (value) {
                                            if (controller.canVibrate.value) Vibrate.feedback(FeedbackType.success);
                                            controller.changeCover(value);
                                          },
                                          indicatorSize: TabBarIndicatorSize.label,
                                          labelStyle: AppTextStyles.base.whiteColor.s10,
                                          // These are the widgets to put in each tab in the tab bar.
                                          tabs: [
                                            Tab(
                                              text: "Movies",
                                            ),
                                            Tab(
                                              text: "Series",
                                            ),
                                          ]),
                                    ),
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
                                child: Obx(
                                  () => Get.find<HomeController>().isLoaded.value == true
                                      ? CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          // imageUrl: "${EndPoints.tmdbImageUrl}${controller.movieDetails.first.posterPath}",
                                          imageUrl: controller.imageUrl.value == "" ? "${EndPoints.tmdbImageUrl}${Get.find<HomeController>().trendingMovies.first.posterPath}" : controller.imageUrl.value,
                                          memCacheHeight: 1942,
                                          memCacheWidth: 1031,
                                        )
                                      : SizedBox.shrink(),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 18),
                                        child: AnimSearchBar(
                                          key: key,
                                          autoFocus: true,
                                          color: Colors.green,
                                          style: AppTextStyles.base.blackColor,
                                          boxShadow: false,
                                          suffixIcon: Icon(
                                            LucideIcons.x,
                                            size: 20,
                                          ),
                                          searchIconColor: Colors.white,
                                          onSubmitted: (p0) {
                                            controller.textController.text = p0;
                                            controller.goToSearchPage();
                                          },
                                          width: Get.width - 40,
                                          textController: controller.textController,
                                          onSuffixTap: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
              SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>("Movies"),
                      slivers: [
                        SliverOverlapInjector(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Container(color: Colors.black, child: HomePage());
                            },
                            childCount: 1,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>("Series"),
                      slivers: [
                        SliverOverlapInjector(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Container(color: Colors.black, child: SeriesPage());
                            },
                            childCount: 1,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
