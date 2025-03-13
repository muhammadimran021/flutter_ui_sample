enum ApiState { Initial, Loading, Success, Error }

class ApiResponseRootModel<T> {
  String? error;
  T? data;
  ApiState? apiState;

  ApiResponseRootModel({this.apiState, this.data, this.error});

  factory ApiResponseRootModel.initial() {
    return ApiResponseRootModel(apiState: ApiState.Initial);
  }
}
