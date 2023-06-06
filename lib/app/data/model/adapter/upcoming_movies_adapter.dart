import 'package:hive/hive.dart';

import '../tmdb/upcoming_movies.dart';

class UpcomingMoviesListAdapter extends TypeAdapter<UpcomingMoviesList> {
  @override
  final typeId = 32; // Update the typeId to a unique value for TrendingSeriesList

  @override
  UpcomingMoviesList read(BinaryReader reader) {
    var dynamicMap = reader.readMap();
    var stringMap = Map<String, dynamic>.from(dynamicMap);
    return UpcomingMoviesList.fromJson(stringMap);
  }

  @override
  void write(BinaryWriter writer, UpcomingMoviesList movies) {
    writer.writeMap(movies.toJson());
  }
}
