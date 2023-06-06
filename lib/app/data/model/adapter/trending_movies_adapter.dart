import 'package:hive/hive.dart';

import '../tmdb/trending_movies.dart';

class TrendingMoviesListAdapter extends TypeAdapter<TrendingMoviesList> {
  @override
  final int typeId = 33; // Update the typeId to a unique value for TrendingMoviesList

  @override
  TrendingMoviesList read(BinaryReader reader) {
    var dynamicMap = reader.readMap();
    var stringMap = Map<String, dynamic>.from(dynamicMap);
    return TrendingMoviesList.fromJson(stringMap);
  }

  @override
  void write(BinaryWriter writer, TrendingMoviesList obj) {
    writer.writeMap(obj.toJson());
  }
}
