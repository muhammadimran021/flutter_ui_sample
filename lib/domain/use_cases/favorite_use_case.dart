import 'package:flutter_ui_sample/data/repository/MoviesRepository.dart';
import 'package:flutter_ui_sample/domain/models/FavoriteResponseModel.dart';
import 'package:flutter_ui_sample/domain/use_cases/BaseUseCase.dart';
import 'package:flutter_ui_sample/presentation/screens/movie_detail_page/favorite_events.dart';

import '../models/ApiResponseRootModel.dart';

class FavoriteUseCase
    extends BaseUseCase<FavoriteResponseModel, FavoriteEvent> {
  final MoviesRepository moviesRepository;

  FavoriteUseCase(this.moviesRepository);

  @override
  Future<FavoriteResponseModel> call(FavoriteEvent params) async {
    final response = await moviesRepository.markFavorite(
      params.endpoint,
      data: params.data,
    );

    if (response.apiState == ApiState.Success) {
      return response.data!;
    } else {
      throw Exception(response.error);
    }
  }
}
