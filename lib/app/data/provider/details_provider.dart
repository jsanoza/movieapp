import 'dart:developer';

import 'package:movie/app/data/api/api_connect.dart';
import 'package:movie/app/data/model/tmdb/movie_details.dart';
import 'package:movie/app/data/model/tmdb/series_details.dart';
import 'package:movie/app/utils/constants.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../model/tmdb/trending_movies.dart';
import '../model/tmdb/videos_list.dart';
import '../model/youtube/video_model.dart';

class DetailsProvider {
  DetailsProvider();

  ApiConnect api = ApiConnect.instance;
  YoutubeExplode ytExplode = YoutubeExplode();

  final Map<String, dynamic> queryParams = {
    'language': "en-US",
  };

  Future<VideosList> getMovieVideos({required String showId}) async {
    var url = Uri.parse("${EndPoints.tmdbUrl}${EndPoints.tmdbMovies}$showId/${EndPoints.tmdbVideos}");
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(
      uri.toString(),
      headers: EndPoints.tmdbHeaders,
    );

    var responseJson = response.body;
    var videos = VideosList.fromJson(responseJson);

    return videos;
  }

  Future<MovieDetails> getMovieDetails({required String showId}) async {
    var url = Uri.parse("${EndPoints.tmdbUrl}${EndPoints.tmdbMovies}$showId");
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(
      uri.toString(),
      headers: EndPoints.tmdbHeaders,
    );

    var responseJson = response.body;
    var movieDetails = MovieDetails.fromJson(responseJson);

    return movieDetails;
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

  Future<TrendingMoviesList> getSimilarMovies({required String showId}) async {
    var url = Uri.parse("${EndPoints.tmdbUrl}${EndPoints.tmdbMovies}$showId/${EndPoints.tmdbSimilar}");
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(
      uri.toString(),
      headers: EndPoints.tmdbHeaders,
    );

    var responseJson = response.body;
    var videos = TrendingMoviesList.fromJson(responseJson);

    return videos;
  }

  // curl --request GET \
  //    --url 'https://api.themoviedb.org/3/movie/569094/similar?language=en-US&page=1' \
  //    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNjRlYzdhOTFjNDY2ZjQzNjI5NTI5Njg2ODEyNjU0YyIsInN1YiI6IjY0N2EyMmM1MGUyOWEyMDExNmFjMzM4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WEE-yq3inZpvvvuZlKBbkp0y9ly_msvhjQ1TMwIRXH0' \
  //    --header 'accept: application/json'

// curl --request GET \
//      --url 'https://api.themoviedb.org/3/movie/movie_id/videos?language=en-US' \
//      --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNjRlYzdhOTFjNDY2ZjQzNjI5NTI5Njg2ODEyNjU0YyIsInN1YiI6IjY0N2EyMmM1MGUyOWEyMDExNmFjMzM4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WEE-yq3inZpvvvuZlKBbkp0y9ly_msvhjQ1TMwIRXH0' \
//      --header 'accept: application/json'

// curl --request GET \
//      --url 'https://api.themoviedb.org/3/movie/movie_id?language=en-US' \
//      --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNjRlYzdhOTFjNDY2ZjQzNjI5NTI5Njg2ODEyNjU0YyIsInN1YiI6IjY0N2EyMmM1MGUyOWEyMDExNmFjMzM4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WEE-yq3inZpvvvuZlKBbkp0y9ly_msvhjQ1TMwIRXH0' \
//      --header 'accept: application/json'
}
