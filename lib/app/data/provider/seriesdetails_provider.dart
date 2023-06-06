import 'dart:developer';

import 'package:movie/app/data/api/api_connect.dart';
import 'package:movie/app/data/model/tmdb/season_details.dart';
import 'package:movie/app/data/model/tmdb/similar_series.dart';
import 'package:movie/app/utils/constants.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../model/tmdb/series_details.dart';
import '../model/tmdb/trending_movies.dart';
import '../model/tmdb/videos_list.dart';
import '../model/youtube/video_model.dart';

class SeriesDetailsProvider {
  SeriesDetailsProvider();

  ApiConnect api = ApiConnect.instance;
  YoutubeExplode ytExplode = YoutubeExplode();

  final Map<String, dynamic> queryParams = {
    'language': "en-US",
  };

  Future<SeriesDetails> getSeriesDetails({required String showId}) async {
    var url = Uri.parse("${EndPoints.tmdbUrl}${EndPoints.tmdbSeries}$showId");
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(
      uri.toString(),
      headers: EndPoints.tmdbHeaders,
    );

    var responseJson = response.body;
    var seriesDetails = SeriesDetails.fromJson(responseJson);

    return seriesDetails;
  }

  Future<VideosList> getSeriesVideos({required String showId}) async {
    var url = Uri.parse("${EndPoints.tmdbUrl}${EndPoints.tmdbSeries}$showId/${EndPoints.tmdbVideos}");
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(
      uri.toString(),
      headers: EndPoints.tmdbHeaders,
    );

    var responseJson = response.body;
    var videos = VideosList.fromJson(responseJson);

    return videos;
  }

  Future<SimilarSeriesList> getSimilarMovies({required String showId}) async {
    var url = Uri.parse("${EndPoints.tmdbUrl}${EndPoints.tmdbSeries}$showId/${EndPoints.tmdbSimilar}");
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(
      uri.toString(),
      headers: EndPoints.tmdbHeaders,
    );

    var responseJson = response.body;
    var videos = SimilarSeriesList.fromJson(responseJson);

    return videos;
  }

  Future<VideoModel> getYTUrls({required String id}) async {
    var manifest = await ytExplode.videos.streamsClient.getManifest(id);
    var video = await ytExplode.videos.get(id);
    var streamInfo = manifest.muxed.withHighestBitrate();

    VideoModel videoModel = VideoModel(
      title: video.title,
      image: video.thumbnails.highResUrl,
      trailerUrl: streamInfo.url.toString(),
      artist: video.author,
      videoId: video.id.toString(),
    );

    log(videoModel.trailerUrl.toString());
    return videoModel;
  }

  Future<SeasonDetails> getSeasons({required String showId, required int seasonNumber}) async {

    var url = Uri.parse("${EndPoints.tmdbUrl}${EndPoints.tmdbSeries}$showId/${EndPoints.tmdbSeason}/${seasonNumber}");
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(
      uri.toString(),
      headers: EndPoints.tmdbHeaders,
    );

    var responseJson = response.body;
    var videos = SeasonDetails.fromJson(responseJson);
    return videos;
  }

  // curl --request GET \
  //    --url 'https://api.themoviedb.org/3/tv/97546/season/1?language=en-US' \
  //    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNjRlYzdhOTFjNDY2ZjQzNjI5NTI5Njg2ODEyNjU0YyIsInN1YiI6IjY0N2EyMmM1MGUyOWEyMDExNmFjMzM4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WEE-yq3inZpvvvuZlKBbkp0y9ly_msvhjQ1TMwIRXH0' \
  //    --header 'accept: application/json'

// curl --request GET \
//      --url 'https://api.themoviedb.org/3/tv/97546/videos?language=en-US' \
//      --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNjRlYzdhOTFjNDY2ZjQzNjI5NTI5Njg2ODEyNjU0YyIsInN1YiI6IjY0N2EyMmM1MGUyOWEyMDExNmFjMzM4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WEE-yq3inZpvvvuZlKBbkp0y9ly_msvhjQ1TMwIRXH0' \
//      --header 'accept: application/json'

// curl --request GET \
//      --url 'https://api.themoviedb.org/3/tv/97546/similar?language=en-US&page=1' \
//      --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNjRlYzdhOTFjNDY2ZjQzNjI5NTI5Njg2ODEyNjU0YyIsInN1YiI6IjY0N2EyMmM1MGUyOWEyMDExNmFjMzM4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WEE-yq3inZpvvvuZlKBbkp0y9ly_msvhjQ1TMwIRXH0' \
//      --header 'accept: application/json'

// curl --request GET \
//    --url 'https://api.themoviedb.org/3/tv/1399/videos?language=en-US' \
//    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNjRlYzdhOTFjNDY2ZjQzNjI5NTI5Njg2ODEyNjU0YyIsInN1YiI6IjY0N2EyMmM1MGUyOWEyMDExNmFjMzM4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WEE-yq3inZpvvvuZlKBbkp0y9ly_msvhjQ1TMwIRXH0' \
//    --header 'accept: application/json'

// curl --request GET \
//      --url 'https://api.themoviedb.org/3/tv/1399?language=en-US' \
//      --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNjRlYzdhOTFjNDY2ZjQzNjI5NTI5Njg2ODEyNjU0YyIsInN1YiI6IjY0N2EyMmM1MGUyOWEyMDExNmFjMzM4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WEE-yq3inZpvvvuZlKBbkp0y9ly_msvhjQ1TMwIRXH0' \
//      --header 'accept: application/json'
}
