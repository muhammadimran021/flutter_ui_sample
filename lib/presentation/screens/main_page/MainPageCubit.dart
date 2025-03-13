import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_state.dart';

class MainPageCubit extends Cubit<GenericState<int>> {
  int pageIndex = 0;

  MainPageCubit() : super(InitialState());

  void changePageIndex(int index) {
    pageIndex = index;
    emit(SuccessState<int>(pageIndex));
  }
}
