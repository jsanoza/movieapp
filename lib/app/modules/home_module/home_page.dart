import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:movie/app/modules/home_module/home_controller.dart';
import 'package:movie/app/themes/app_text_theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../utils/constants.dart';
import '../../utils/widgets/ui/section_title.dart';
import '../../utils/widgets/ui/trending_container.dart';
import '../../utils/widgets/ui/upcoming_container.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
        ),
        Obx(() => controller.isLoaded.value == true
            ? SectionTitle(
                text: "🔥 Trending Movies",
              )
            : SizedBox.shrink()),
        Obx(() => controller.isLoaded.value == true
            ? TrendingContainer(
                list: controller.trendingMovies,
                controller: controller,
                isMovie: true,
              )
            : SizedBox.shrink()),
        SizedBox(
          height: 20,
        ),
        Obx(() => controller.isLoaded.value == true
            ? SectionTitle(
                text: "📆 Upcoming Movies",
              )
            : SizedBox.shrink()),
        Obx(() => controller.isLoaded.value == true
            ? UpcomingContainer(
                list: controller.upcomingMovies,
                controller: controller,
                isMovie: true,
              )
            : SizedBox.shrink()),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
