import 'package:movie_app_bloc/model/movie.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class GenreMovieState extends BaseState {
  final error;
  final bool isLoading;
  final List<Movie> list;
  final int page;
  final int id;

  @override
  // TODO: implement props
  List<Object?> get props => [error, isLoading, list, page, id];

  GenreMovieState({
    this.error,
    this.isLoading = false,
    this.list = const [],
    this.page = 0,
    this.id = 0,
  });

  GenreMovieState copyWith({
    bool? isLoading,
    var error,
    List<Movie>? list,
    int? page,
    int? id
  }) =>
      GenreMovieState(
          error: error,
          isLoading: isLoading ?? false,
          list: list ?? this.list,
          page: page ?? this.page,
          id: id ?? this.id
      );
}