import 'dart:async';
import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../app/data/provider/seriesdetails_provider.dart';
import '../../data/model/tmdb/season_details.dart';
import '../../data/model/tmdb/series_details.dart';
import '../../data/model/tmdb/similar_series.dart';
import '../../data/model/tmdb/trending_movies.dart';
import '../../data/model/tmdb/videos_list.dart';
import '../../data/model/youtube/video_model.dart';
import '../../utils/common.dart';
import '../../utils/network_connectivitiy.dart';
import '../../utils/widgets/app_video_player/app_video_player.dart';

class SeriesDetailsController extends GetxController with NetworkConnectivityMixin {
  final SeriesDetailsProvider? provider;
  SeriesDetailsController({this.provider});
  StreamSubscription<ConnectivityResult>? subscription;

  var isLoaded = false.obs;
  var isVideosLoaded = false.obs;
  var isSeasonDataLoaded = false.obs;
  var headerImageurl = "".obs;
  var top = 0.0.obs;
  var seriesId = "".obs;
  List<bool> expandedList = <bool>[].obs;
  YoutubeExplode ytExplode = YoutubeExplode();

  var isNetwork = true.obs;

  List<VideoDetails> videoList = <VideoDetails>[].obs;
  List<SeriesDetails> seriesDetails = <SeriesDetails>[].obs;
  List<SimilarSeries> similarSerieses = <SimilarSeries>[].obs;
  List<VideoModel> videoModel = <VideoModel>[].obs;
  List<Seasons> seriesSeasons = <Seasons>[].obs;
  List<SeasonDetails> seasonDetails = <SeasonDetails>[].obs;

  var canVibrate = false.obs;

  initVibrate() async {
    canVibrate.value = await Vibrate.canVibrate;
  }

  void updateTop(double value) {
    top.value = value;
  }

  void toggleExpansion(int index, int seasonNumber) {
    expandedList[index] = !expandedList[index];

    if (expandedList[index] == true) {
      getSeasonDetails(seasonNumber: seasonNumber, showId: seriesId.value);
    } else {
      seasonDetails.clear();
      isSeasonDataLoaded.value = false;
    }
  }

  void initializeExpansionState() {
    expandedList = List<bool>.filled(seriesSeasons.length, false);
  }

  getSeriesDetails({required String showId}) async {
    try {
      var results = await provider!.getSeriesDetails(showId: showId);
      seriesDetails.add(results);
      seriesSeasons.addAll(results.seasons!);
      initializeExpansionState();
      isLoaded.value = true;
    } catch (e) {
      isNetwork.value = false;
    }
  }

  getSeasonDetails({required String showId, required int seasonNumber}) async {
    var results = await provider!.getSeasons(showId: showId, seasonNumber: seasonNumber);
    seasonDetails.add(results);
    isSeasonDataLoaded.value = true;
  }

  getYTUrls() async {
    var filteredList = videoList.where((video) => video.site!.toLowerCase() == 'youtube').take(5).toList();
    for (var video in filteredList) {
      videoModel.add(await provider!.getYTUrls(id: video.key!));
    }
  }

  getSeriesVideos({required String showId}) async {
    final value = await provider!.getSeriesVideos(showId: showId);
    final filteredList = value.results!.where((video) => video.site!.toLowerCase() == 'youtube').take(2).toList();
    final futures = filteredList.map((video) => provider!.getYTUrls(id: video.key!));
    final videoModels = await Future.wait(futures);
    videoModel.addAll(videoModels);
    isVideosLoaded.value = true;
  }

  getSimilarMovies({required String showId}) async {
    var results = await provider!.getSimilarMovies(showId: showId);
    similarSerieses.addAll(results.results!);
  }

  viewVideos({required VideoModel videoModel}) async {
    Get.dialog(
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultPlayer(
                url: videoModel.trailerUrl.toString(),
              ),
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.9));
  }

  openLink({required String url}) async {
    canLaunchUrl(Uri.parse(url)).then((bool result) async {
      await launchUrl(Uri.parse(url));
    }).onError((error, stackTrace) {
      if (Get.isSnackbarOpen) {
        Get.back();
      } else {
        Common.showError("No website available.", Duration(milliseconds: 2000));
      }
    });
  }

  initialLoading({required String showId}) async {
    List<Future> futures = <Future>[].obs;
    seriesId.value = showId;
    // futures.add(getSeriesVideos(showId: showId));
    futures.add(getSeriesDetails(showId: showId));

    futures.add(getSeriesVideos(showId: showId));

    futures.add(getSimilarMovies(showId: showId));

    await Future.wait(futures).then((value) {});
  }

  Future<void> checkNetworkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      isNetwork.value = false;
    } else {
      isNetwork.value = true;
      initialLoading(showId: seriesId.value);
      if (!Get.isSnackbarOpen) {
        Common.showError("Connection Restored", Duration(milliseconds: 5000));
      }
    }
  }

  @override
  void onInit() {
    initVibrate();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      checkNetworkConnectivity();
    });
    super.onInit();
  }
}
