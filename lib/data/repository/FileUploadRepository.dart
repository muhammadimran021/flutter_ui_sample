import 'dart:io';

import 'package:flutter_ui_sample/domain/models/ApiResponseRootModel.dart';
import 'package:flutter_ui_sample/domain/models/FileUploadResponseModel.dart';

abstract class FileUploadRepository {
  Future<ApiResponseRootModel<FileUploadResponseModel>> uploadFile(
    String url,
    File data,
  );
}
