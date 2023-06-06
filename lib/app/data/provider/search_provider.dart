import 'package:movie/app/data/api/api_connect.dart';
import 'package:movie/app/utils/constants.dart';

import '../model/tmdb/search_results.dart';
import '../model/tmdb/trending_series.dart';

class SearchProvider {
  SearchProvider();
  ApiConnect api = ApiConnect.instance;

  Future<SearchResults> multiSearch({required String searchTerm}) async {
    final Map<String, String> queryParams = {
      'query': searchTerm,
      'include_adult': 'false',
      'language': 'en-US',
      'page': '1',
    };

    var url = Uri.parse("${EndPoints.tmdbUrl}${EndPoints.tmdbSearch}${EndPoints.tmdbSearchMulti}");
    var uri = url.replace(queryParameters: queryParams);

    final response = await api.get(uri.toString(), headers: EndPoints.tmdbHeaders);

    var responseJson = response.body;
    var searchResults = SearchResults.fromJson(responseJson);

    return searchResults;
  }
  // curl --request GET \
  //    --url 'https://api.themoviedb.org/3/search/multi?query=kaleidoscope&include_adult=false&language=en-US&page=1' \
  //    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNjRlYzdhOTFjNDY2ZjQzNjI5NTI5Njg2ODEyNjU0YyIsInN1YiI6IjY0N2EyMmM1MGUyOWEyMDExNmFjMzM4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WEE-yq3inZpvvvuZlKBbkp0y9ly_msvhjQ1TMwIRXH0' \
  //    --header 'accept: application/json'
}
