import '../../../domain/models/FileUploadResponseModel.dart';

abstract class UserProfile {}

class UserProfileInitialState extends UserProfile {}

class UserFileUploadLoadingState extends UserProfile {}

class UserFileUploadSuccessState extends UserProfile {
  final FileUploadResponseModel data;

  UserFileUploadSuccessState(this.data);
}

class UserFileUploadErrorState extends UserProfile {
  final String message;

  UserFileUploadErrorState(this.message);
}
