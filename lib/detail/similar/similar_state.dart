import 'package:movie_app_bloc/model/movie/movie.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class SimilarMovieState extends RefresherBaseState<Movie> {
  final otherError;
  final int page;
  final bool errorLoadMore;
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
        errorLoadMore,
        page,
        errorRefresh
      ];

  SimilarMovieState(
      {isFirstLoad = true,
      isLoading = false,
      isLoadingMore = false,
      error,
      list,
      itemAttributes,
      this.otherError,
      this.errorLoadMore = false,
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
  SimilarMovieState copyWith({
    bool? isFirstLoad,
    bool? isLoading,
    bool? isLoadingMore,
    var error,
    List<Movie>? list,
    BaseItemAttributes? itemAttributes,
    var otherError,
    bool? errorLoadMore,
    bool? errorRefresh,
    int? page,
  }) =>
      SimilarMovieState(
          isFirstLoad: isFirstLoad ?? this.isFirstLoad,
          isLoading: isLoading ?? false,
          isLoadingMore: isLoadingMore ?? this.isLoadingMore,
          error: error,
          list: list ?? this.list,
          itemAttributes: itemAttributes ?? this.itemAttributes,
          otherError: otherError,
          page: page ?? this.page,
          errorLoadMore: errorLoadMore ?? this.errorLoadMore,
          errorRefresh: errorRefresh ?? this.errorRefresh);
}
