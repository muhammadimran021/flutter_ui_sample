import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/domain/models/GenresModel.dart';
import 'package:flutter_ui_sample/domain/models/TopRatedMoviesRootModel.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_event.dart';

import '../../../data/repository/MoviesRepository.dart';
import '../../../domain/models/ApiResponseRootModel.dart';
import '../../blocs/api_state.dart';

class MoviesBloc extends Bloc<GenericEvent, GenericState> {
  final MoviesRepository moviesRepository;

  MoviesBloc(this.moviesRepository) : super(InitialState()) {
    /// get data from top rated movies api
    on<FetchDataEvent<TopRatedMoviesRootModel>>((event, emit) async {
      emit(LoadingState<TopRatedMoviesRootModel>());
      final moviesResponse = await moviesRepository.getTopRatedMovies(
        event.endpoint,
        params: event.params,
      );
      if (moviesResponse.apiState == ApiState.Success) {
        emit(SuccessState<TopRatedMoviesRootModel>(moviesResponse.data!));
      } else {
        emit(ErrorState<TopRatedMoviesRootModel>(moviesResponse.error!));
      }
    });

    /// get data from movies genres api
    on<FetchDataEvent<GenresModel>>((event, emit) async {
      emit(LoadingState<GenresModel>());
      final genresResponse = await moviesRepository.getMovesGenres(
        event.endpoint,
        params: event.params,
      );
      if (genresResponse.apiState == ApiState.Success) {
        emit(SuccessState<GenresModel>(genresResponse.data!));
      } else {
        emit(ErrorState<GenresModel>(genresResponse.error!));
      }
    });
  }
}
