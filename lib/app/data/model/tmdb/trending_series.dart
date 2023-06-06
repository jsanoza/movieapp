import 'package:hive/hive.dart';
@HiveType(typeId: 35)
class TrendingSeriesList extends HiveObject {
  int? page;
  List<TrendingSeries>? results;
  int? totalPages;
  int? totalResults;

  TrendingSeriesList({this.page, this.results, this.totalPages, this.totalResults});

  TrendingSeriesList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <TrendingSeries>[];
      json['results'].forEach((v) {
        results!.add(TrendingSeries.fromJson(Map<String, dynamic>.from(v)));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class TrendingSeries {
  bool? adult;
  String? backdropPath;
  int? id;
  String? name;
  String? originalLanguage;
  String? originalName;
  String? overview;
  String? posterPath;
  String? mediaType;
  List<int>? genreIds;
  double? popularity;
  String? firstAirDate;
  double? voteAverage;
  int? voteCount;
  List<String>? originCountry;

  TrendingSeries({this.adult, this.backdropPath, this.id, this.name, this.originalLanguage, this.originalName, this.overview, this.posterPath, this.mediaType, this.genreIds, this.popularity, this.firstAirDate, this.voteAverage, this.voteCount, this.originCountry});

  TrendingSeries.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    name = json['name'];
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    genreIds = json['genre_ids'].cast<int>();
    popularity = json['popularity'];
    firstAirDate = json['first_air_date'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    originCountry = json['origin_country'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['id'] = this.id;
    data['name'] = this.name;
    data['original_language'] = this.originalLanguage;
    data['original_name'] = this.originalName;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['media_type'] = this.mediaType;
    data['genre_ids'] = this.genreIds;
    data['popularity'] = this.popularity;
    data['first_air_date'] = this.firstAirDate;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['origin_country'] = this.originCountry;
    return data;
  }
}
