import 'package:movie_app_bloc/model/movie/movie.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class SearchMovieState extends RefresherBaseState<Movie> {
  final otherError;
  final int page;
  final bool errorLoadmore;
  final bool errorRefresh;

  @override
  // TODO: implement props
  List<Object?> get props => [
        error,
        isLoading,
        list,
        isFirstLoad,
        isLoadingMore,
        otherError,
        errorLoadmore,
        page,
        errorRefresh
      ];

  SearchMovieState(
      {isFirstLoad = false,
      isLoading = false,
      isLoadingMore = false,
      error,
      list,
      itemAttributes,
      this.otherError,
      this.errorLoadmore = false,
      this.page = 1,
      this.errorRefresh = false})
      : super(
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
    bool? errorLoadmore,
    bool? errorRefresh,
    int? page,
  }) =>
      SearchMovieState(
          isFirstLoad: isFirstLoad ?? this.isFirstLoad,
          isLoading: isLoading ?? false,
          isLoadingMore: isLoadingMore ?? this.isLoadingMore,
          error: error,
          list: list ?? this.list,
          itemAttributes: itemAttributes ?? this.itemAttributes,
          otherError: otherError,
          page: page ?? this.page,
          errorLoadmore: errorLoadmore ?? this.errorLoadmore,
          errorRefresh: errorRefresh ?? this.errorRefresh);
}
