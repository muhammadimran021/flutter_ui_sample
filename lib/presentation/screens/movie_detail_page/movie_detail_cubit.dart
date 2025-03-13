import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/domain/use_cases/favorite_use_case.dart';
import 'package:flutter_ui_sample/presentation/screens/movie_detail_page/favorite_events.dart';
import 'package:flutter_ui_sample/presentation/screens/movie_detail_page/favorite_states.dart';

class MovieDetailPageCubit extends Cubit<FavoriteState> {
  final FavoriteUseCase favoriteUseCase;

  MovieDetailPageCubit(this.favoriteUseCase) : super(FavoriteInitialState());

  Future<void> markFavorite(FavoriteEvent event) async {
    emit(FavoriteLoadingState());
    final response = await favoriteUseCase.call(event);
    try {
      emit(FavoriteSuccessState(response));
    } catch (e) {
      emit(FavoriteErrorState(e.toString()));
    }
  }
}
