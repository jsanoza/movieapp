import 'dart:developer';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_animated_tabbar/easy_animated_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../app/modules/search_module/search_controller.dart';
import '../../data/model/tmdb/search_results.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_theme.dart';
import '../../utils/constants.dart';
import '../../utils/loading.dart';
import '../../utils/widgets/ui/genre_container.dart';

class SearchPage extends GetWidget<SearchPageController> {
  const SearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.delete<SearchPageController>();
        return Future(() => true);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                        Get.delete<SearchPageController>();
                      },
                      icon: Icon(
                        LucideIcons.chevronLeft,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                          controller.getMultiSearch(searchTerm: p0);
                        },
                        width: Get.width - 60,
                        textController: controller.textController,
                        onSuffixTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: EasyAnimatedTab(
                    buttonTitles: ["All", "Movies", "Series"],
                    onSelected: (index) {
                      if (index == 0) {
                        controller.index.value = 0;
                        log(controller.index.value.toString());
                      } else if (index == 1) {
                        controller.index.value = 1;
                        log(controller.index.value.toString());
                      } else if (index == 2) {
                        controller.index.value = 2;
                        log(controller.index.value.toString());
                      }
                    },
                    animationDuration: 500,
                    minWidthOfItem: 70,
                    minHeightOfItem: 40,
                    deActiveItemColor: Colors.white,
                    activeItemColor: Colors.green,
                    activeTextStyle: TextStyle(color: Colors.white, fontSize: 14),
                    deActiveTextStyle: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Obx(
                  () => Text(
                    controller.getHeaderText(controller.index.value),
                    style: AppTextStyles.base.whiteColor.s24,
                  ),
                ),
              ],
            ),
            Obx(() => controller.isLoading.value == true
                ? Expanded(
                    child: SearchList(
                      goToDetails: (id, initialImage, showKind) {
                        controller.goToDetails(id: id, showKind: showKind, initialImage: initialImage);
                      },
                      //list will base on the selected item on the EasyAnimatedTab, i have 3 list: searchResults, movieResults and seriesResults
                      list: controller.index.value == 0
                          ? controller.searchResults
                          : controller.index.value == 1
                              ? controller.movieResults
                              : controller.seriesResults,
                    ),
                  )
                : Expanded(child: Loading()))
          ],
        ),
      ),
    );
  }
}

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.list, required this.goToDetails});

  final List<dynamic> list;
  final Function(String id, String initialimage, String showKind) goToDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Obx(
        () => ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                goToDetails(
                  list[index].id.toString(),
                  list[index].posterPath != null ? "${EndPoints.tmdbImageUrl}${list[index].posterPath.toString()}" : EndPoints.dummyImageUrl,
                  list[index].mediaType.toString(),
                );
              },
              child: Container(
                width: Get.width,
                padding: EdgeInsets.only(left: 4.0, right: 16, top: 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: list[index].posterPath != null ? "${EndPoints.tmdbImageUrl}${list[index].posterPath}" : EndPoints.dummyImageUrl,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(list[index].name ?? list[index].title!, style: AppTextStyles.base.whiteColor.w900.s18),
                          SizedBox(height: 4.0),
                          Text("${list[index].mediaType!.toUpperCase()} ●", style: AppTextStyles.base.whiteColor.s12),
                          SizedBox(height: 4.0),
                          Text("Release date ● ${list[index].releaseDate ?? list[index].firstAirDate}", style: AppTextStyles.base.whiteColor.s12),
                          SizedBox(height: 4.0),
                          Text("${list[index].overview!} ", style: AppTextStyles.base.whiteColor.s12),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Icon(
                        LucideIcons.expand,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
