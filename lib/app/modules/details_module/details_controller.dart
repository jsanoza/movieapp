import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:movie/app/data/model/tmdb/videos_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../app/data/provider/details_provider.dart';
import '../../data/model/tmdb/movie_details.dart';
import '../../data/model/tmdb/trending_movies.dart';
import '../../data/model/youtube/video_model.dart';
import '../../utils/common.dart';
import '../../utils/network_connectivitiy.dart';
import '../../utils/widgets/app_video_player/app_video_player.dart';

class DetailsController extends GetxController with NetworkConnectivityMixin {
  final DetailsProvider? provider;
  DetailsController({this.provider});
  StreamSubscription<ConnectivityResult>? subscription;

  var isLoaded = false.obs;
  var isVideosLoaded = false.obs;
  var isNetwork = true.obs;
  var movieId = "".obs;
  List<VideoDetails> videoList = <VideoDetails>[].obs;
  List<MovieDetails> movieDetails = <MovieDetails>[].obs;
  List<VideoModel> videoModel = <VideoModel>[].obs;
  List<TrendingMovies> trendingMovies = <TrendingMovies>[].obs;

  var headerImageurl = "".obs;
  var top = 0.0.obs;

  var canVibrate = false.obs;

  initVibrate() async {
    canVibrate.value = await Vibrate.canVibrate;
  }

  void updateTop(double value) {
    top.value = value;
  }

  getYTUrls() async {
    var filteredList = videoList.where((video) => video.site!.toLowerCase() == 'youtube').take(5).toList();
    for (var video in filteredList) {
      videoModel.add(await provider!.getYTUrls(id: video.key!));
    }
  }

  getFirstTrailerUrl() async {
    var video = videoList.firstWhere(
      (video) => video.type!.toLowerCase() == 'trailer' && video.site!.toLowerCase() == 'youtube',
    );
    var results = await provider!.getYTUrls(id: video.key!);
    viewVideos(videoModel: results);
  }

  getMovieVideos({required String showId}) async {
    final value = await provider!.getMovieVideos(showId: showId);
    final filteredList = value.results!.where((video) => video.site!.toLowerCase() == 'youtube').take(2).toList();

    final futures = filteredList.map((video) => provider!.getYTUrls(id: video.key!));
    final videoModels = await Future.wait(futures);
    videoModel.addAll(videoModels);
    isVideosLoaded.value = true;
  }

  getMovieDetails({required String showId}) async {
    try {
      var results = await provider!.getMovieDetails(showId: showId);
      movieDetails.add(results);
      isLoaded.value = true;
    } catch (e) {
      isNetwork.value = false;
    }
  }

  getSimilarMovies({required String showId}) async {
    var results = await provider!.getSimilarMovies(showId: showId);
    trendingMovies.addAll(results.results!);
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
    movieId.value = showId;
    futures.add(getMovieDetails(showId: showId));

    futures.add(getMovieVideos(showId: showId));

    futures.add(getSimilarMovies(showId: showId));

    await Future.wait(futures).then((value) {});
  }

  Future<void> checkNetworkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      isNetwork.value = false;
    } else {
      isNetwork.value = true;
      initialLoading(showId: movieId.value);
      if (!Get.isSnackbarOpen) {
        Common.showError("Connection Restored", Duration(milliseconds: 5000));
      }
    }
  }

  @override
  void onInit() {
    // initNetworkConnectivity();
    initVibrate();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      checkNetworkConnectivity();
    });
    super.onInit();
  }
}
