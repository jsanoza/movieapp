import 'package:hive/hive.dart';
import '../tmdb/upcoming_series.dart';

class UpcomingSeriesListAdapter extends TypeAdapter<UpcomingSeriesList> {
  @override
  final typeId = 34; // Update the typeId to a unique value for TrendingSeriesList

  @override
  UpcomingSeriesList read(BinaryReader reader) {
    var dynamicMap = reader.readMap();
    var stringMap = Map<String, dynamic>.from(dynamicMap);
    return UpcomingSeriesList.fromJson(stringMap);
  }

  @override
  void write(BinaryWriter writer, UpcomingSeriesList series) {
    writer.writeMap(series.toJson());
  }
}
