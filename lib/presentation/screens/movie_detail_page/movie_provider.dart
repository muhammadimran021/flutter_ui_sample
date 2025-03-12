import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/data/repository/MoviesRepository.dart';
import 'package:flutter_ui_sample/domain/models/ApiResponseRootModel.dart';
import 'package:flutter_ui_sample/domain/models/FavoriteResponseModel.dart';
import 'package:flutter_ui_sample/domain/repository_impl/MoviesRepository_Impl.dart';

class MovieDetailPageProvider extends ChangeNotifier {
  final MoviesRepository moviesRepository = MoviesRepositoryImpl();
  late ApiResponseRootModel<FavoriteResponseModel> favoriteResponseModel =
      ApiResponseRootModel.initial();

  Future<void> markFavorite(String url, {Map<String, dynamic>? data}) async {
    try {
      favoriteResponseModel = ApiResponseRootModel(apiState: ApiState.Loading);
      notifyListeners();
      final response = await moviesRepository.markFavorite(url, data: data);
      if (response.data != null) {
        favoriteResponseModel = ApiResponseRootModel(
          apiState: ApiState.Success,
          data: response.data,
        );
      } else {
        favoriteResponseModel = ApiResponseRootModel(
          apiState: ApiState.Error,
          error: response.error,
        );
      }
    } catch (e) {
      favoriteResponseModel = ApiResponseRootModel(
        apiState: ApiState.Error,
        error: e.toString(),
      );
    } finally {
      notifyListeners();
    }
  }
}
