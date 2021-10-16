import 'package:movie_app_bloc/model/detail_movie/MovieDetail.dart';

class MovieDetailResponse {
  final MovieDetail movieDetail;

  MovieDetailResponse(this.movieDetail);

  MovieDetailResponse.fromJson(Map<String, dynamic> json)
      : movieDetail = MovieDetail.fromJson(json);

}
