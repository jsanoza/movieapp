import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:movie/app/data/provider/search_provider.dart';
import 'package:movie/app/modules/search_module/search_page.dart';
import 'package:movie/app/routes/app_pages.dart';
import '../../../app/data/provider/base_provider.dart';
import '../../utils/constants.dart';
import '../../utils/network_connectivitiy.dart';
import '../home_module/home_controller.dart';
import '../search_module/search_controller.dart';

class BaseController extends GetxController with NetworkConnectivityMixin {
  final BaseProvider? provider;
  BaseController({this.provider});

  TextEditingController textController = TextEditingController();
  var top = 0.0.obs;
  var imageUrl = "".obs;

  var canVibrate = false.obs;

  initVibrate() async {
    canVibrate.value = await Vibrate.canVibrate;
  }

  @override
  void onInit() {
    initVibrate();
    super.onInit();
  }

  void updateTop(double value) {
    top.value = value;
  }

  changeCover(int tabName) async {
    if (tabName == 0) {
      imageUrl.value = "${EndPoints.tmdbImageUrl}${Get.find<HomeController>().trendingMovies.first.posterPath}";
    }
    if (tabName == 1) {
      imageUrl.value = "${EndPoints.tmdbImageUrl}${Get.find<HomeController>().trendingSeries.first.posterPath}";
    }
  }

  goToSearchPage() async {
    if (canVibrate.value) Vibrate.feedback(FeedbackType.success);
    Get.put(SearchPageController(provider: SearchProvider()));
    Get.find<SearchPageController>().searchTerm.value = textController.text;
    Get.find<SearchPageController>().textController.text = textController.text;
    Get.find<SearchPageController>().getMultiSearch(searchTerm: textController.text);
    Get.toNamed(AppRoutes.search);
  }
}
