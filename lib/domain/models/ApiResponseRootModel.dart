enum ApiState { Success, Error }

class ApiResponseRootModel<T> {
  String? error;
  T? data;
  ApiState? apiState;
  int? statusCode;

  ApiResponseRootModel({this.apiState, this.data, this.error,this.statusCode});


}
