import 'package:flutter_ui_sample/data/repository/MoviesRepository.dart';
import 'package:flutter_ui_sample/domain/models/ApiResponseRootModel.dart';
import 'package:flutter_ui_sample/domain/models/GenresModel.dart';
import 'package:flutter_ui_sample/domain/use_cases/BaseUseCase.dart';
import 'package:flutter_ui_sample/presentation/screens/movies_page/moives_events.dart';

class GenresMoviesUseCase extends BaseUseCase<GenresModel, GenresMoviesEvent> {
  final MoviesRepository moviesRepository;

  GenresMoviesUseCase(this.moviesRepository);

  @override
  Future<GenresModel> call(GenresMoviesEvent params) async {
    final response = await moviesRepository.getMovesGenres(
      params.endpoint,
      params: params.params,
    );
    if (response.apiState == ApiState.Success) {
      return response.data!;
    } else {
      throw Exception(response.error);
    }
  }
}
