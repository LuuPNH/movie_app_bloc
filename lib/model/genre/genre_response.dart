import 'genre.dart';

class GenreResponse {
  final List<Genre>? genres;

  GenreResponse(this.genres);

  GenreResponse.fromJson(Map<String, dynamic> json)
      : genres =
            (json["genres"] as List).map((e) => new Genre.fromJson(e)).toList();
}
