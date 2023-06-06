import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/app/data/model/tmdb/series_details.dart';
import 'package:movie/app/data/model/tmdb/trending_movies.dart';
import 'package:movie/app/data/model/tmdb/upcoming_movies.dart';
import 'package:movie/app/data/model/tmdb/upcoming_series.dart';
import 'package:movie/app/data/provider/details_provider.dart';
import 'package:movie/app/data/provider/home_provider.dart';
import 'package:movie/app/data/provider/seriesdetails_provider.dart';
import 'package:movie/app/modules/details_module/details_controller.dart';
import 'package:movie/app/modules/seriesdetails_module/seriesdetails_controller.dart';
import 'package:movie/app/routes/app_pages.dart';
import 'package:movie/app/utils/network_connectivitiy.dart';
import '../../data/model/tmdb/trending_series.dart';

class HomeController extends GetxController with NetworkConnectivityMixin {
  HomeController({this.provider});
  final HomeProvider? provider;

  List<UpcomingMovies> upcomingMovies = <UpcomingMovies>[].obs;
  List<TrendingMovies> trendingMovies = <TrendingMovies>[].obs;
  List<TrendingSeries> trendingSeries = <TrendingSeries>[].obs;
  List<UpcomingSeries> upcomingSeries = <UpcomingSeries>[].obs;

  var isLoaded = false.obs;
  var trendingMoviesCondition = "day".obs;
  var trendingSeriesCondition = "day".obs;
  var top = 0.0.obs;
  void updateTop(double value) {
    top.value = value;
  }

  getUpcomingMovies() async {
    var results = await provider!.fetchUpcomingMovies();
    upcomingMovies.addAll(results.results!);
  }

  getUpcomingSeries() async {
    var results = await provider!.fetchUpcomingSeries();
    upcomingSeries.addAll(results.results!);
  }

  getTrendingMovies({required String condition}) async {
    var results = await provider!.fetchTrendingMovies(condition: condition);
    trendingMovies.addAll(results.results!);
  }

  getTrendingSeries({required String condition}) async {
    var results = await provider!.fetchTrendingSeries(condition: condition);
    trendingSeries.addAll(results.results!);
    trendingSeries.sort((a, b) => b.voteAverage!.compareTo(a.voteAverage!));
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

  initialLoading() async {
    List<Future> futures = [
      getUpcomingMovies(),
      getUpcomingSeries(),
      getTrendingMovies(condition: trendingMoviesCondition.value),
      getTrendingSeries(condition: trendingSeriesCondition.value),
    ];
    await Future.wait(futures).then((value) {
      isLoaded.value = true;
    });
  }

  @override
  void onInit() {
    initialLoading();
    initNetworkConnectivity();
    super.onInit();
  }
}
