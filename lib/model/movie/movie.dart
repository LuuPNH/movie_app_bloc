class Movie {
  final int? id;
  final double? popularity;
  final String? title;
  final String? backPoster;
  final String? poster;
  final String? overview;
  final double? rating;

  Movie(
      {this.id,
      this.popularity,
      this.title,
      this.backPoster,
      this.poster,
      this.overview,
      this.rating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"],
      popularity: json["popularity"],
      title: json["title"],
      backPoster: json["backdrop_path"],
      poster: json["poster_path"],
      overview: json["overview"],
      rating: json["vote_average"].toDouble(),
    );
  }

  Movie copyWith({
    int? id,
    double? popularity,
    String? title,
    String? backPoster,
    String? poster,
    String? overview,
    double? rating,
  }) {
    return new Movie(
        id: id ?? this.id,
        popularity: popularity ?? this.popularity,
        title: title ?? this.title,
        backPoster: backPoster ?? this.backPoster,
        poster: poster ?? this.poster,
        overview: overview ?? this.overview,
        rating: rating ?? this.rating);
  }
}
