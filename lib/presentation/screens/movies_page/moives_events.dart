abstract class MoviesEvents {}

class TopRatedMoviesEvent extends MoviesEvents {
  final String endpoint; // API endpoint
  final Map<String, dynamic>? params; // Query parameters
  TopRatedMoviesEvent({required this.endpoint, this.params});
}

class GenresMoviesEvent extends MoviesEvents {
  final String endpoint; // API endpoint
  final Map<String, dynamic>? params; // Query parameters
  GenresMoviesEvent({required this.endpoint, this.params});
}
