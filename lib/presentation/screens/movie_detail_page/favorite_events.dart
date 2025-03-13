abstract class MovieDetailsEvents {}

class FavoriteEvent extends MovieDetailsEvents {
  final String endpoint; // API endpoint
  final Map<String, dynamic>? params; // Query parameters
  final Map<String, dynamic>? data; // Query parameters
  FavoriteEvent({required this.endpoint, this.params, this.data});
}
