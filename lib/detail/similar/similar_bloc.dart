import 'package:movie_app_bloc/detail/similar/similar_event.dart';
import 'package:movie_app_bloc/detail/similar/similar_state.dart';
import 'package:movie_app_bloc/model/movie/movie.dart';
import 'package:movie_app_bloc/repository/repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class SimilarMovieBloc extends BaseBloc<SimilarMovieState> {
  SimilarMovieBloc() : super(SimilarMovieState(isLoading: true));

  MovieRepository movieRepository = MovieRepository();

  @override
  Stream<SimilarMovieState> mapEventToState(BaseEvent event) async* {
    if (event is SimilarMovieEvent) {
      var list = await movieRepository.getSimilarMovie(event.id, event.pageKey);
      yield state.copyWith(list: list);
    }
    if (event is SimilarMovieMoreEvent) {
      List<Movie>? li;
      if (state.list?.isNotEmpty == true) {
        List<Movie>? _list =
        await movieRepository.getSimilarMovie(event.id, event.pageKey);
        li = [...state.list!, ..._list];
        yield state.copyWith(list: li);
      }
    }
  }
}
