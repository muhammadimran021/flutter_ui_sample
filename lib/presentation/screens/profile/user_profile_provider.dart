import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ui_sample/domain/models/ApiResponseRootModel.dart';
import 'package:flutter_ui_sample/domain/models/FileUploadResponseModel.dart';

import '../../../data/repository/FileUploadRepository.dart';
import '../../../domain/repository_impl/FileUploadRepositoryImpl.dart';

class UserProfileProvider extends ChangeNotifier {
  final FileUploadRepository _fileUploadRepository = FileUploadRepositoryImpl();
  ApiResponseRootModel<FileUploadResponseModel> apiResponseRootModel =
      ApiResponseRootModel.initial();

  void uploadFile(String url, File file) async {
    apiResponseRootModel.apiState = ApiState.Loading;
    notifyListeners();

    apiResponseRootModel = await _fileUploadRepository.uploadFile(url, file);
    notifyListeners();
  }
}
