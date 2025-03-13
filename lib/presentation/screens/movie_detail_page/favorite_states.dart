import '../../../domain/models/FavoriteResponseModel.dart';

abstract class FavoriteState {}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteSuccessState extends FavoriteState {
  final FavoriteResponseModel data;

  FavoriteSuccessState(this.data);
}

class FavoriteErrorState extends FavoriteState {
  final String message;

  FavoriteErrorState(this.message);
}
