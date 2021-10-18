import 'package:movie_app_bloc/model/detail_movie/MovieDetail.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class MovieDetailState extends BaseState {
  final error;
  final bool isLoading;
  final MovieDetail? item;

  @override
  // TODO: implement props
  List<Object?> get props => [error, isLoading, item];

  MovieDetailState(
      {this.error, this.isLoading = false, this.item});

  MovieDetailState copyWith({
    bool? isLoading,
    var error,
    MovieDetail? item
  }) =>
      MovieDetailState(
          error: error,
          isLoading: isLoading ?? false,
          item: item ?? this.item);
}
