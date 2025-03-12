import 'dart:io';

import 'package:flutter_ui_sample/data/network/DioProvider.dart';
import 'package:flutter_ui_sample/domain/models/ApiResponseRootModel.dart';
import 'package:flutter_ui_sample/domain/models/FileUploadResponseModel.dart';

import '../../data/repository/FileUploadRepository.dart';

class FileUploadRepositoryImpl extends FileUploadRepository {
  final DioProvider dioProvider = DioProvider();

  @override
  Future<ApiResponseRootModel<FileUploadResponseModel>> uploadFile(
    String url,
    File data,
  ) async {
    try {
      final response = await dioProvider.uploadFile(url, data);
      if (response.statusCode == 200 ||
          response.statusCode == 201 && response.data != null) {
        final parsedResponse = FileUploadResponseModel.fromJson(response.data);
        return ApiResponseRootModel(
          apiState: ApiState.Success,
          data: parsedResponse,
        );
      } else {
        return ApiResponseRootModel(
          apiState: ApiState.Error,
          error: response.statusMessage,
        );
      }
    } catch (e) {
      return ApiResponseRootModel(
        apiState: ApiState.Error,
        error: e.toString(),
      );
    }
  }
}
