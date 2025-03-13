import 'package:flutter_ui_sample/data/repository/FileUploadRepository.dart';
import 'package:flutter_ui_sample/domain/models/ApiResponseRootModel.dart';
import 'package:flutter_ui_sample/domain/models/FileUploadResponseModel.dart';
import 'package:flutter_ui_sample/domain/use_cases/BaseUseCase.dart';
import 'package:flutter_ui_sample/presentation/screens/profile/user_profile_envents.dart';

class UserFileUploadUseCase
    extends BaseUseCase<FileUploadResponseModel, UserProfileUploadEvents> {
  final FileUploadRepository _fileUploadRepository;

  UserFileUploadUseCase(this._fileUploadRepository);

  @override
  Future<FileUploadResponseModel> call(UserProfileUploadEvents params) async {
    final response = await _fileUploadRepository.uploadFile(
      params.endpoint,
      params.data!["file"],
    );

    if (response.apiState == ApiState.Success) {
      return response.data!;
    } else {
      throw Exception(response.error);
    }
  }
}
