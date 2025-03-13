import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/domain/use_cases/genres_movies_use_case.dart';

import '../../../domain/use_cases/top_rated_movies_uses_case.dart';
import 'moives_events.dart';
import 'movies_states.dart';

class MoviesBloc extends Bloc<MoviesEvents, MoviesState> {
  final TopRateMoviesUseCase topRateMoviesUseCase;
  final GenresMoviesUseCase genresMoviesUseCase;

  MoviesBloc(this.topRateMoviesUseCase, this.genresMoviesUseCase)
    : super(InitialState()) {
    /// get data from top rated movies api
    on<TopRatedMoviesEvent>((event, emit) async {
      emit(TopRatedMoviesLoadingState());
      try {
        final moviesResponse = await topRateMoviesUseCase.call(event);
        emit(TopRatedMoviesSuccess(moviesResponse));
      } catch (e) {
        emit(TopRatedMoviesErrorState(e.toString()));
      }
    });

    /// get data from movies genres api
    on<GenresMoviesEvent>((event, emit) async {
      emit(GenresLoadingState());
      final genresResponse = await genresMoviesUseCase.call(event);
      try {
        emit(GenresMoviesSuccess(genresResponse));
      } catch (e) {
        emit(GenresErrorState(e.toString()));
      }
    });
  }
}

