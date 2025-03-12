import 'package:flutter_ui_sample/domain/models/FavoriteResponseModel.dart';
import 'package:flutter_ui_sample/domain/models/GenresModel.dart';
import 'package:flutter_ui_sample/domain/models/TopRatedMoviesRootModel.dart';

import '../../data/network/DioProvider.dart';
import '../../data/repository/MoviesRepository.dart';
import '../models/ApiResponseRootModel.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final DioProvider _dioProvider = DioProvider();

  @override
  Future<ApiResponseRootModel<GenresModel>> getMovesGenres(
    String url, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dioProvider.get(url, params: params);
      if (response.statusCode == 200 && response.data != null) {
        final parsedResponse = GenresModel.fromJson(response.data);
        return ApiResponseRootModel(
          apiState: ApiState.Success,
          data: parsedResponse,
        );
      } else {
        return ApiResponseRootModel(
          apiState: ApiState.Error,
          error:
              "Server error: ${response.statusCode} - ${response.statusMessage}",
        );
      }
    } catch (e) {
      return ApiResponseRootModel(
        apiState: ApiState.Error,
        error: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponseRootModel<TopRatedMoviesRootModel>> getTopRatedMovies(
    String url, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dioProvider.get(url, params: params);
      if (response.statusCode == 200 && response.data != null) {
        final parsedResponse = TopRatedMoviesRootModel.fromJson(response.data);
        return ApiResponseRootModel(
          apiState: ApiState.Success,
          data: parsedResponse,
        );
      } else {
        return ApiResponseRootModel(
          apiState: ApiState.Error,
          error:
              "Server error: ${response.statusCode} - ${response.statusMessage}",
        );
      }
    } catch (e) {
      return ApiResponseRootModel(
        apiState: ApiState.Error,
        error: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponseRootModel<FavoriteResponseModel>> markFavorite(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dioProvider.post(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201 && response.data != null) {
        final parsedResponse = FavoriteResponseModel.fromJson(response.data);
        return ApiResponseRootModel(
          apiState: ApiState.Success,
          data: parsedResponse,
        );
      } else {
        return ApiResponseRootModel(
          apiState: ApiState.Error,
          error:
              "Server error: ${response.statusCode} - ${response.statusMessage}",
        );
      }
    } catch (e) {
      return ApiResponseRootModel(
        apiState: ApiState.Error,
        error: e.toString(),
      );
    }
  }
}
