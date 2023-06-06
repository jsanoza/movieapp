import 'dart:developer';
import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';
import 'package:movie/app/data/api/api_connect.dart';
import 'package:movie/app/data/model/tmdb/trending_series.dart';
import 'package:movie/app/data/model/tmdb/upcoming_series.dart';
import 'package:movie/app/utils/constants.dart';
import '../model/tmdb/trending_movies.dart';
import '../model/tmdb/upcoming_movies.dart';

class HomeProvider {
  HomeProvider();
  ApiConnect api = ApiConnect.instance;



    /// UPCOMING MOVIES ///
  


  Future<UpcomingMoviesList> getUpcomingMovies() async {
    final box = await Hive.openBox('newUpComingBox');
    final Map<String, dynamic> queryParams = {
      'language': 'en-US',
      'page': '1',
    };

    var url = Uri.parse("${EndPoints.tmdbUrl}${EndPoints.tmbdbUpcomingMovies}");
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(
      uri.toString(),
      headers: EndPoints.tmdbHeaders,
    );

    var responseJson = response.body;
    var movies = UpcomingMoviesList.fromJson(responseJson);

    // Save the movies to Hive
    await box.put('upcomingMovies', movies);

    return movies;
  }

  Future<UpcomingMoviesList?> getSavedMovies() async {
    final box = await Hive.openBox('newUpComingBox');
    return box.get('upcomingMovies') as UpcomingMoviesList?;
  }

  Future<UpcomingMoviesList> fetchUpcomingMovies() async {
    // Check for internet connection
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      return await getUpcomingMovies();
    } else {
      // No internet connection, fetch from Hive
      return await getSavedMovies() ?? UpcomingMoviesList(); // Return an empty list if no saved data is available
    }
  }


    /// UPCOMING SERIES ///

  Future<UpcomingSeriesList> getUpcomingSeries() async {
    final box = await Hive.openBox('newUpcomingSeriesBox');
    final Map<String, dynamic> queryParams = {
      'air_date.gte': "2023",
      'air_date.lte': '2023',
      'first_air_date_year': '2023',
      'first_air_date.gte': '2023',
      'first_air_date.lte': '2023',
      'include_adult': 'false',
      'include_null_first_air_dates': 'false',
      'sort_by': 'popularity.desc',
      'with_origin_country': 'US',
      'language': 'en-US',
    };

    var url = Uri.parse("${EndPoints.tmdbUrl}${EndPoints.tmdbUpcomingSeries}");
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(uri.toString(), headers: EndPoints.tmdbHeaders);

    var responseJson = response.body;
    var upcomingTvShows = UpcomingSeriesList.fromJson(responseJson);

    // Save the upcoming TV shows to Hive
    await box.put('upcomingSeries', upcomingTvShows);

    return upcomingTvShows;
  }

  Future<UpcomingSeriesList?> getSavedSeries() async {
    final box = await Hive.openBox('newUpcomingSeriesBox');
    return box.get('upcomingSeries') as UpcomingSeriesList?;
  }

  Future<UpcomingSeriesList> fetchUpcomingSeries() async {
    // Check for internet connection
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      return await getUpcomingSeries();
    } else {
      // No internet connection, fetch from Hive
      return await getSavedSeries() ?? UpcomingSeriesList(); // Return an empty list if no saved data is available
    }
  }


  /// TRENDING MOVIES ///

  Future<TrendingMoviesList> getTrendingMovies({required String condition}) async {
    final box = await Hive.openBox('newTrendingBox');
    final String trendingMoviesBoxKey = 'trendingMovies';

    // Check if the data is available in Hive
    if (box.containsKey(trendingMoviesBoxKey)) {
      return box.get(trendingMoviesBoxKey) as TrendingMoviesList;
    }

    final Map<String, dynamic> queryParams = {
      'language': 'en-US',
      'page': '1',
      'time_window': condition,
    };

    String trendingMoviesUrl;
    if (condition == "day") {
      trendingMoviesUrl = "${EndPoints.tmdbUrl}${EndPoints.tmdbTrendingMoviesDay}";
    } else {
      trendingMoviesUrl = "${EndPoints.tmdbUrl}${EndPoints.tmdbTrendingMoviesWeek}";
    }

    var url = Uri.parse(trendingMoviesUrl);
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(
      uri.toString(),
      headers: EndPoints.tmdbHeaders,
    );

    var responseJson = response.body;
    var movies = TrendingMoviesList.fromJson(responseJson);

    // Save the movies to Hive
    await box.put(trendingMoviesBoxKey, movies);

    return movies;
  }

  Future<TrendingMoviesList?> getSavedTrendingMovies() async {
    final box = await Hive.openBox('newTrendingBox');
    return box.get('trendingMovies') as TrendingMoviesList?;
  }

  Future<TrendingMoviesList> fetchTrendingMovies({required String condition}) async {
    // Check for internet connection
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      return await getTrendingMovies(condition: condition);
    } else {
      // No internet connection, fetch from Hive
      return await getSavedTrendingMovies() ?? TrendingMoviesList(); // Return an empty list if no saved data is available
    }
  }




  /// TRENDING SERIES ///

  Future<TrendingSeriesList> getTrendingSeries({required String condition}) async {
    final box = await Hive.openBox('newTrendingSeriesBox');
    final Map<String, dynamic> queryParams = {
      'language': "en-US",
      'page': '1',
      'time_window': condition,
    };

    String trendingSeriesUrl;
    if (condition == "day") {
      trendingSeriesUrl = "${EndPoints.tmdbUrl}${EndPoints.tmdbTrendingSeriesDay}";
    } else {
      trendingSeriesUrl = "${EndPoints.tmdbUrl}${EndPoints.tmdbTrendingSeriesWeek}";
    }

    Uri url = Uri.parse(trendingSeriesUrl);
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(uri.toString(), headers: EndPoints.tmdbHeaders);

    var responseJson = response.body;
    var trendingSeries = TrendingSeriesList.fromJson(responseJson);

    // Save the trending series to Hive
    await box.put('trendingSeries', trendingSeries);

    return trendingSeries;
  }

  Future<TrendingSeriesList?> getSavedTrendingSeries() async {
    final box = await Hive.openBox('newTrendingSeriesBox');
    return box.get('trendingSeries') as TrendingSeriesList?;
  }

  Future<TrendingSeriesList> fetchTrendingSeries({required String condition}) async {
    // Check for internet connection
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      return await getTrendingSeries(condition: condition);
    } else {
      // No internet connection, fetch from Hive
      return await getSavedTrendingSeries() ?? TrendingSeriesList(); // Return an empty list if no saved data is available
    }
  }
}
