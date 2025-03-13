import 'api_state.dart';

bool shouldBuildWhen<T>(GenericState current) {
  return current is SuccessState<T> ||
      current is LoadingState<T> ||
      current is InitialState<T> ||
      current is ErrorState<T>;
}