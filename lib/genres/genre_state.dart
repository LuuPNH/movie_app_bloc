import 'package:movie_app_bloc/model/genre/genre.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class GenreState extends BaseState {
  final error;
  final bool isLoading;
  final List<Genre> list;

  @override
  // TODO: implement props
  List<Object?> get props => [error, isLoading, list];

  GenreState(
      {this.error, this.isLoading = false, this.list = const []});

  GenreState copyWith({
    bool? isLoading,
    var error,
    List<Genre>? list,
  }) =>
      GenreState(
          error: error,
          isLoading: isLoading ?? false,
          list: list ?? this.list);
}