import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/data/repository/MoviesRepository.dart';
import 'package:flutter_ui_sample/domain/models/ApiResponseRootModel.dart';
import 'package:flutter_ui_sample/domain/models/FavoriteResponseModel.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_event.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_state.dart';

class MovieDetailPageCubit
    extends Cubit<GenericState<FavoriteResponseModel>> {
  final MoviesRepository moviesRepository;

  MovieDetailPageCubit(this.moviesRepository) : super(InitialState());

  Future<void> markFavorite(FetchDataEvent event) async {
    emit(LoadingState<FavoriteResponseModel>());
    final response = await moviesRepository.markFavorite(event.endpoint, data: event.params);
    if (response.apiState == ApiState.Success) {
      emit(SuccessState<FavoriteResponseModel>(response.data!));
    } else {
      emit(ErrorState<FavoriteResponseModel>(response.error!));
    }
  }
}
