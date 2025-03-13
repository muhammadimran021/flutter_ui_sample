abstract class GenericState<T> {}

class InitialState<T> extends GenericState<T> {}

class LoadingState<T> extends GenericState<T> {}

class SuccessState<T> extends GenericState<T> {
  final T data;

  SuccessState(this.data);
}

class ErrorState<T> extends GenericState<T> {
  final String message;

  ErrorState(this.message);
}