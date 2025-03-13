import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/domain/models/ApiResponseRootModel.dart';
import 'package:flutter_ui_sample/domain/models/FileUploadResponseModel.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_event.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_state.dart';

import '../../../data/repository/FileUploadRepository.dart';

class UserProfileBloc extends Bloc<GenericEvent, GenericState> {
  final FileUploadRepository _fileUploadRepository;

  UserProfileBloc(this._fileUploadRepository) : super(InitialState()) {
    on<FetchDataEvent<FileUploadResponseModel>>((event, emit) async {
      emit(LoadingState<FileUploadResponseModel>());
      final file = event.params!['file'];
      final fileUploadResponse = await _fileUploadRepository.uploadFile(
        event.endpoint,
        file,
      );
      if (fileUploadResponse.apiState == ApiState.Success) {
        emit(SuccessState<FileUploadResponseModel>(fileUploadResponse.data!));
      } else {
        emit(ErrorState<FileUploadResponseModel>(fileUploadResponse.error!));
      }
    });
  }
}
