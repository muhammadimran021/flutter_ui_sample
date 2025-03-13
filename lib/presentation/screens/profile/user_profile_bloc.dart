import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/domain/use_cases/user_file_upload_use_case.dart';
import 'package:flutter_ui_sample/presentation/screens/profile/user_profile_envents.dart';
import 'package:flutter_ui_sample/presentation/screens/profile/user_profile_states.dart';

class UserProfileBloc extends Bloc<UserProfileEvents, UserProfile> {
  final UserFileUploadUseCase _fileUploadUseCase;

  UserProfileBloc(this._fileUploadUseCase) : super(UserProfileInitialState()) {
    on<UserProfileUploadEvents>((event, emit) async {
      emit(UserFileUploadLoadingState());
      try {
        final data = await _fileUploadUseCase.call(event);
        emit(UserFileUploadSuccessState(data));
      } catch (e) {
        emit(UserFileUploadErrorState(e.toString()));
      }
    });
  }
}
