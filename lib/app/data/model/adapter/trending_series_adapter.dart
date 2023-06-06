import 'package:hive/hive.dart';

import '../tmdb/trending_series.dart';

class TrendingSeriesListAdapter extends TypeAdapter<TrendingSeriesList> {
  @override
  final int typeId = 35; // Update the typeId to a unique value for TrendingSeriesList

  @override
  TrendingSeriesList read(BinaryReader reader) {
    var dynamicMap = reader.readMap();
    var stringMap = Map<String, dynamic>.from(dynamicMap);
    return TrendingSeriesList.fromJson(stringMap);
  }

  @override
  void write(BinaryWriter writer, TrendingSeriesList obj) {
    writer.writeMap(obj.toJson());
  }
}