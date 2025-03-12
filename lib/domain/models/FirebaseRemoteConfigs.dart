import 'dart:convert';

class FirebaseRemoteConfigs {
  static final FirebaseRemoteConfigs _instance =
      FirebaseRemoteConfigs._internal();

  String? tmdbBaseUrl;
  String? apiKey;
  String? authToken;
  String? apiBaseUrl;
  String? moviesImageBaseUrl;
  String? topRatedMoviesPath;
  String? genreMovieListPath;
  String? markFavorite;
  String? uploadFilePath;
  String? language;
  String? page;

  // Private constructor
  FirebaseRemoteConfigs._internal();

  // Factory constructor for accessing the instance
  factory FirebaseRemoteConfigs() => _instance;

  static FirebaseRemoteConfigs get instance => _instance;

  // Initialize data from JSON
  void saveJSON(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    tmdbBaseUrl = json["tmdb_base_url"];
    apiKey = json["api_key"];
    authToken = json["auth_token"];
    apiBaseUrl = json["api_base_url"];
    moviesImageBaseUrl = json["movies_image_base_url"];
    topRatedMoviesPath = json["top_rated_movies_path"];
    genreMovieListPath = json["genre_movie_list_path"];
    markFavorite = json["mark_favorite"];
    uploadFilePath = json["upload_file_path"];
    language = json["language"];
    page = json["page"];
  }

  // Convert to JSON
  Map<String, dynamic> toJson() => {
    "tmdb_base_url": tmdbBaseUrl,
    "api_key": apiKey,
    "auth_token": authToken,
    "api_base_url": apiBaseUrl,
    "movies_image_base_url": moviesImageBaseUrl,
    "top_rated_movies_path": topRatedMoviesPath,
    "genre_movie_list_path": genreMovieListPath,
    "mark_favorite": markFavorite,
    "upload_file_path": uploadFilePath,
    "language": language,
    "page": page,
  };
}
