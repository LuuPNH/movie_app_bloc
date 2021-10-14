

import 'package:movie_app_bloc/model/movie.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class NowPlayingState extends BaseState {
  final error;
  final bool isLoading;
  final List<Movie> list;

  @override
  // TODO: implement props
  List<Object?> get props => [error, isLoading, list];

  NowPlayingState(
      {this.error, this.isLoading = false, this.list = const []});

  NowPlayingState copyWith({
    bool? isLoading,
    var error,
    List<Movie>? list,
  }) =>
      NowPlayingState(
          error: error,
          isLoading: isLoading ?? false,
          list: list ?? this.list);
}
