import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/data/repository/SplashRepository.dart';
import 'package:flutter_ui_sample/domain/models/FirebaseRemoteConfigs.dart';

import '../../blocs/api_state.dart';

class SplashCubit extends Cubit<GenericState<FirebaseRemoteConfigs>> {
  final SplashRepository splashRepository;

  SplashCubit(this.splashRepository) : super(InitialState());

  Future<void> fetchAndActivate() async {
    emit(LoadingState<FirebaseRemoteConfigs>());
    await splashRepository.fetchAndActivate();
    emit(SuccessState<FirebaseRemoteConfigs>(FirebaseRemoteConfigs.instance));
  }
}
