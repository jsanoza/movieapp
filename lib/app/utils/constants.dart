class EndPoints {
  const EndPoints._();

  static const String baseUrl = '';
  static const String login = "";
  static const String user = "";

  static const Duration timeout = Duration(seconds: 30);
  static const String transcriptionUrl = 'https://api.openai.com/v1/audio/transcriptions';
  static const String chatUrl = 'https://api.openai.com/v1/chat/completions';

  static const String tmdbUrl = "https://api.themoviedb.org/3/";
  static const String tmbdbUpcomingMovies = "movie/upcoming";
  static const String tmdbUpcomingSeries = "discover/tv";
  static const String tmdbTrendingMoviesDay = "trending/movie/day";
  static const String tmdbTrendingMoviesWeek = "trending/movie/week";
  static const String tmdbTrendingSeriesDay = "trending/tv/day";
  static const String tmdbTrendingSeriesWeek = "trending/tv/week";

  static const String tmdbMovies = "movie/";
  static const String tmdbSeries = "tv/";
  static const String tmdbVideos = "videos";
  static const String tmdbSimilar = "similar";
  static const String tmdbSeason = "season";
  static const String tmdbSearch = "search/";
  static const String tmdbSearchMulti = "multi";

  static const String transcribeModel = "whisper-1";

  static const Map<String, String> tmdbHeaders = {
    'accept': 'application/json',
    'Authorization': 'Bearer $tmdbKey',
  };

  static const Map<String, String> openAiHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $openAiKEY',
  };

  static const String tmdbImageUrl = "https://image.tmdb.org/t/p/original/";
  static const String dummyImageUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png';
  static const String placeHolderBlurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

  static const String tmdbKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNjRlYzdhOTFjNDY2ZjQzNjI5NTI5Njg2ODEyNjU0YyIsInN1YiI6IjY0N2EyMmM1MGUyOWEyMDExNmFjMzM4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WEE-yq3inZpvvvuZlKBbkp0y9ly_msvhjQ1TMwIRXH0";
  static const String openAiKEY = ""; //please insert your openai api key here
}

enum LoadDataState { initialize, loading, loaded, error, timeout, unknownerror }
