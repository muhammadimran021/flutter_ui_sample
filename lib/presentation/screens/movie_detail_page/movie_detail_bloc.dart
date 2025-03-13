import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/data/repository/MoviesRepository.dart';
import 'package:flutter_ui_sample/domain/models/FavoriteResponseModel.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_event.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_state.dart';

import '../../../domain/models/ApiResponseRootModel.dart';

class MovieDetailBloc extends Bloc<GenericEvent, GenericState> {
  final MoviesRepository moviesRepository;

  MovieDetailBloc(this.moviesRepository) : super(InitialState()) {
    on<FetchDataEvent<FavoriteResponseModel>>((event, emit) async {
      emit(LoadingState<FavoriteResponseModel>());
      final favoriteResponse = await moviesRepository.markFavorite(
        event.endpoint,
        data: event.body,
      );
      if (favoriteResponse.apiState == ApiState.Success) {
        emit(SuccessState<FavoriteResponseModel>(favoriteResponse.data!));
      } else {
        emit(ErrorState<FavoriteResponseModel>(favoriteResponse.error!));
      }
    });
  }
}
