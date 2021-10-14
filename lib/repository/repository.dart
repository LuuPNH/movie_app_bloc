import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_app_bloc/model/movie.dart';
import 'package:movie_app_bloc/model/movie_response.dart';

class MovieRepository {
  final String apiKey = "96ab22f969e17fcd4b92e1d1c73b4dbc";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var movieUrl = "$mainUrl/movie";
  var searchMovieUrl = "$mainUrl/search/movie";

  Future<List<Movie>> getPlayingMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try{
      var response = await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data).movies ;
    }catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return [];
    }
  }
}
