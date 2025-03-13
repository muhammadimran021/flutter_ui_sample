import '../../../domain/models/GenresModel.dart';
import '../../../domain/models/TopRatedMoviesRootModel.dart';

abstract class MoviesState {}

class InitialState extends MoviesState {}

class GenresLoadingState extends MoviesState {}

class TopRatedMoviesLoadingState extends MoviesState {}

class GenresErrorState extends MoviesState {
  final String message;

  GenresErrorState(this.message);
}

class TopRatedMoviesErrorState extends MoviesState {
  final String message;

  TopRatedMoviesErrorState(this.message);
}

class ErrorState extends MoviesState {
  final String message;

  ErrorState(this.message);
}

class TopRatedMoviesSuccess extends MoviesState {
  final TopRatedMoviesRootModel data;

  TopRatedMoviesSuccess(this.data);
}

class GenresMoviesSuccess extends MoviesState {
  final GenresModel data;

  GenresMoviesSuccess(this.data);
}
