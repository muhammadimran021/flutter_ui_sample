import 'package:flutter_ui_sample/domain/models/ApiResponseRootModel.dart';
import 'package:flutter_ui_sample/domain/models/GenresModel.dart';
import 'package:flutter_ui_sample/domain/models/TopRatedMoviesRootModel.dart';

import '../../domain/models/FavoriteResponseModel.dart';

abstract class MoviesRepository {
  Future<ApiResponseRootModel<TopRatedMoviesRootModel>> getTopRatedMovies(String url, {Map<String, dynamic>? params});

  Future<ApiResponseRootModel<GenresModel>> getMovesGenres(String url, {Map<String, dynamic>? params});
  Future<ApiResponseRootModel<FavoriteResponseModel>> markFavorite(String url, {Map<String, dynamic>? data});
}
