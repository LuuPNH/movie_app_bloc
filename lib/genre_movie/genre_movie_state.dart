import 'package:movie_app_bloc/model/movie.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class GenreMovieState extends RefresherBaseState<Movie> {
  final otherError;


  @override
  // TODO: implement props
  List<Object?> get props => [
    error,
    isLoading,
    list,
    isFirstLoad,
    isLoadingMore,
    otherError
  ];

  GenreMovieState({
    isFirstLoad = true,
    isLoading = false,
    isLoadingMore = false,
    error,
    list,
    itemAttributes,
    this.otherError,
  }) : super(
    isFirstLoad: isFirstLoad,
    isLoading: isLoading,
    isLoadingMore: isLoadingMore,
    error: error,
    list: list,
    itemAttributes: itemAttributes,
  );

  @override
  GenreMovieState copyWith({
    bool? isFirstLoad,
    bool? isLoading,
    bool? isLoadingMore,
    var error,
    List<Movie>? list,
    BaseItemAttributes? itemAttributes,
    var otherError,
  }) =>
      GenreMovieState(
        isFirstLoad: isFirstLoad ?? this.isFirstLoad,
        isLoading: isLoading ?? false,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        error: error,
        list: list ?? this.list,
        itemAttributes: itemAttributes ?? this.itemAttributes,
        otherError: otherError,
      );

}