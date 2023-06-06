import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../app/data/provider/search_provider.dart';
import '../../data/model/tmdb/search_results.dart';
import '../../data/model/tmdb/trending_series.dart';
import '../../data/provider/details_provider.dart';
import '../../data/provider/seriesdetails_provider.dart';
import '../../routes/app_pages.dart';
import '../../utils/network_connectivitiy.dart';
import '../details_module/details_controller.dart';
import '../seriesdetails_module/seriesdetails_controller.dart';

class SearchPageController extends GetxController with NetworkConnectivityMixin {
  final SearchProvider? provider;
  SearchPageController({this.provider});

  var searchTerm = "".obs;
  var isLoading = false.obs;
  var index = 0.obs;

  TextEditingController textController = TextEditingController();
  List<SearchItems> searchResults = <SearchItems>[].obs;
  List<SearchItems> movieResults = <SearchItems>[].obs;
  List<SearchItems> seriesResults = <SearchItems>[].obs;

  getMultiSearch({required String searchTerm}) async {
    isLoading.value = false;
    searchResults.clear();
    movieResults.clear();
    seriesResults.clear();
    var results = await provider!.multiSearch(searchTerm: searchTerm);
    searchResults.addAll(results.results!);

    movieResults = searchResults.where((item) => item.mediaType == 'movie').toList();
    seriesResults = searchResults.where((item) => item.mediaType == 'tv').toList();

    isLoading.value = true;
  }

  goToDetails({required String id, required String showKind, required String initialImage}) async {
    if (showKind == "tv") {
      Get.put(SeriesDetailsController(provider: SeriesDetailsProvider()));
      Get.find<SeriesDetailsController>().initialLoading(showId: id);
      Get.find<SeriesDetailsController>().headerImageurl.value = initialImage;
      Get.toNamed(AppRoutes.seriesdetails);
    }
    if (showKind == "movie") {
      Get.put(DetailsController(provider: DetailsProvider()));
      Get.find<DetailsController>().initialLoading(showId: id);
      Get.find<DetailsController>().headerImageurl.value = initialImage;
      Get.toNamed(AppRoutes.details);
    }
  }

  String getHeaderText(int index) {
    if (index == 0) {
      return "Search Results";
    } else if (index == 1) {
      return "Movie Results";
    } else if (index == 2) {
      return "Series Results";
    } else {
      return "";
    }
  }

  @override
  void onInit() {
    initNetworkConnectivity();
    super.onInit();
  }
}
