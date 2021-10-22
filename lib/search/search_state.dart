import 'package:movie_app_bloc/model/movie/movie.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class SearchMovieState extends RefresherBaseState<Movie> {
  final otherError;
  final List<Movie>? listLoadMore;
  final bool errorLoadmore;
  final bool errorRefresh;


  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        error,
        isLoading,
        list,
        isFirstLoad,
        isLoadingMore,
        otherError,
        errorLoadmore,
        listLoadMore,
        errorRefresh
      ];

  SearchMovieState({
    isFirstLoad = false,
    isLoading = false,
    isLoadingMore = false,
    error,
    list,
    itemAttributes,
    this.otherError,
    this.errorLoadmore = false,
    this.listLoadMore,
    this.errorRefresh = false

  }) : super(
    isFirstLoad: isFirstLoad,
    isLoading: isLoading,
    isLoadingMore: isLoadingMore,
    error: error,
    list: list,
    itemAttributes: itemAttributes,
  );

  @override
  SearchMovieState copyWith({
    bool? isFirstLoad,
    bool? isLoading,
    bool? isLoadingMore,
    var error,
    List<Movie>? list,
    BaseItemAttributes? itemAttributes,
    var otherError,
    List<Movie>? listLoadMore,
    bool? errorLoadmore,
    bool? errorRefresh
  }) =>
      SearchMovieState(
          isFirstLoad: isFirstLoad ?? this.isFirstLoad,
          isLoading: isLoading ?? false,
          isLoadingMore: isLoadingMore ?? this.isLoadingMore,
          error: error,
          list: list ?? this.list,
          itemAttributes: itemAttributes ?? this.itemAttributes,
          otherError: otherError,
          listLoadMore: listLoadMore ?? this.listLoadMore,
          errorLoadmore: errorLoadmore ?? this.errorLoadmore,
          errorRefresh: errorRefresh ?? this.errorRefresh
      );

}