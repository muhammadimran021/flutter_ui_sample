import 'dart:io';

import 'package:dio/dio.dart';

class DioProvider {
  static final DioProvider _instance = DioProvider._internal();
  late final Dio _dio;
  late final Dio _dioForFileUpload;

  // Private constructor
  DioProvider._internal();

  factory DioProvider() => _instance;

  // Initialize Dio Once
  void initialize({required String baseUrl, required String authKey}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authKey',
        },
      ),
    );


    // Add Interceptors
    _addInterceptors(_dio);
  }

  /// set Different base url for file upload
  void setFileUploadBaseUrl(String newBaseUrl) {
    _dioForFileUpload = _cloneDio(_dio, newBaseUrl);
  }

  /// ======================== New Dio Client ====================

  Dio _cloneDio(Dio dio, String newBaseUrl) {
    return Dio(
      BaseOptions(
        baseUrl: newBaseUrl,
        connectTimeout: dio.options.connectTimeout,
        receiveTimeout: dio.options.receiveTimeout,
        headers: dio.options.headers,
      ),
    )..interceptors.addAll(dio.interceptors); // Copy interceptors
  }
  /// ======================== New Dio Client ====================



  void _addInterceptors(Dio dioInstance) {
    dioInstance.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('Error: ${e.response?.statusCode} ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  // GET Request
  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(url, queryParameters: params);
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // POST Request
  Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // File Upload with Optional Extra Data
  Future<Response> uploadFile(
    String url,
    File file, {
    Map<String, dynamic>? data,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        ...?data,
      });

      final response = await _dioForFileUpload.post(url, data: formData);
      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Private Error Handling Method
  Response _handleError(DioException e) {
    print('Dio Error: ${e.message}');
    throw Exception("Network Error: ${e.response?.statusCode} ${e.message}");
  }
}
