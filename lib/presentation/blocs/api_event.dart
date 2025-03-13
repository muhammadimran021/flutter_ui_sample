abstract class GenericEvent<T> {}

class FetchDataEvent<T> extends GenericEvent<T> {
  final String endpoint; // API endpoint
  final Map<String, dynamic>? params; // Query parameters
  final Map<String, dynamic>? body; // Request body (for POST/PUT)

  FetchDataEvent({required this.endpoint, this.params, this.body});
}
