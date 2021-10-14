import 'movie.dart';

class MovieResponse {
  final List<Movie> movies;

  MovieResponse(this.movies);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
      .map((i) => new Movie.fromJson(i))
      .toList();
}