import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_app_bloc/model/detail_movie/MovieDetail.dart';
import 'package:movie_app_bloc/model/detail_movie/MovieDetailResponse.dart';
import 'package:movie_app_bloc/model/genre/genre.dart';
import 'package:movie_app_bloc/model/genre/genre_response.dart';
import 'package:movie_app_bloc/model/movie/movie.dart';
import 'package:movie_app_bloc/model/movie/movie_response.dart';
import 'package:movie_app_bloc/model/person/person.dart';
import 'package:movie_app_bloc/model/person/person_response.dart';
import 'package:movie_app_bloc/model/video/video.dart';
import 'package:movie_app_bloc/model/video/video_response.dart';

class MovieRepository {
  final String apiKey = "96ab22f969e17fcd4b92e1d1c73b4dbc";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesByGenreUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var getMovielUrl = "$mainUrl/movie";
  var searchMovieUrl = "$mainUrl/search/movie";

  Future<List<Movie>> getPlayingMovies() async {
    var params = {"api_key": apiKey, "page": 1};
    try {
      var response = await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data).movies;
    } catch (error, stacktrace) {
      print("Exception Repositoty: $error stackTrace: $stacktrace");
      return [];
    }
  }

  Future<List<Genre>?> getGenres() async {
    var params = {"api_key": apiKey, "page": 1};
    try {
      var response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data).genres;
    } catch (error, stacktrace) {
      print("Exception Repositoty: $error stackTrace: $stacktrace");
      return [];
    }
  }

  Future<List<Movie>> getMovieByGenre(int id, int page) async {
    var params = {
      "api_key": apiKey,
      "page": page,
      "with_genres": id
    };
    try {
      Response response =
          await _dio.get(getMoviesByGenreUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data).movies;
    } catch (error, stacktrace) {
      print("Exception Repositoty: $error stackTrace: $stacktrace");
      return [];
    }
  }
  Future<List<Person>> getPersons(int page) async {
    var params = {
      "api_key": apiKey,
      "page": page,
    };
    try {
      Response response =
      await _dio.get(getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data).persons;
    } catch (error, stacktrace) {
      print("Exception Repositoty: $error stackTrace: $stacktrace");
      return [];
    }
  }
  Future<List<Movie>> getPopularMovies(int page) async {
    var params = {
      "api_key": apiKey,
      "page": page,
    };
    try {
      Response response =
      await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data).movies;
    } catch (error, stacktrace) {
      print("Exception Repositoty: $error stackTrace: $stacktrace");
      return [];
    }
  }
  Future<MovieDetail> getMovieDetail(int id, int page) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": page
    };
    try {
      Response response =
      await _dio.get(getMovielUrl + "/$id", queryParameters: params);
      return MovieDetailResponse.fromJson(response.data).movieDetail;
    } catch (error, stacktrace) {
      print("Exception Repositoty: $error stackTrace: $stacktrace");
      return MovieDetail(1,false, 1,[],"erorr", 1);
    }
  }
  Future<Video> getVideo(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
    };
    try {
      Response response =
      await _dio.get(getMovielUrl + "/$id" + "/videos");
      return VideoResponse.fromJson(response.data).videos;
    } catch (error, stacktrace) {
      print("Exception Repositoty: $error stackTrace: $stacktrace");
      return Video("1", "hihi", "hihi", "site", "");
    }
  }
}
