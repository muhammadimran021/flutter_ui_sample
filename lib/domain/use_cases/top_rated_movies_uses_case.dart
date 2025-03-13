import 'package:flutter_ui_sample/domain/models/ApiResponseRootModel.dart';
import 'package:flutter_ui_sample/domain/models/TopRatedMoviesRootModel.dart';
import 'package:flutter_ui_sample/domain/use_cases/BaseUseCase.dart';
import 'package:flutter_ui_sample/presentation/screens/movies_page/moives_events.dart';

import '../../data/repository/MoviesRepository.dart';

class TopRateMoviesUseCase
    extends BaseUseCase<TopRatedMoviesRootModel, TopRatedMoviesEvent> {
  final MoviesRepository moviesRepository;

  TopRateMoviesUseCase(this.moviesRepository);

  @override
  Future<TopRatedMoviesRootModel> call(TopRatedMoviesEvent params) async {
    final response = await moviesRepository.getTopRatedMovies(
      params.endpoint,
      params: params.params,
    );
    if (response.apiState == ApiState.Success) {
      return response.data!;
    } else {
      throw Exception(response.error!);
    }
  }
}
