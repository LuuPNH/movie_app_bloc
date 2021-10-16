import 'package:movie_app_bloc/model/movie/movie.dart';
import 'package:movie_app_bloc/popular/popular_event.dart';
import 'package:movie_app_bloc/popular/popular_state.dart';
import 'package:movie_app_bloc/repository/repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class PopularMovieBloc extends BaseBloc<PopularMovieState> {
  PopularMovieBloc() : super(PopularMovieState(isLoading: true));

  MovieRepository movieRepository = MovieRepository();

  @override
  Stream<PopularMovieState> mapEventToState(BaseEvent event) async* {
    if (event is PopularMovieEvent) {
      var list = await movieRepository.getPopularMovies(event.pageKey);
      yield state.copyWith(list: list);
    }
    if (event is PopularMovieMoreEvent) {
      List<Movie>? li;
      if (state.list?.isNotEmpty == true) {
        List<Movie>? _list =
        await movieRepository.getPopularMovies(event.pageKey);
        li = [...state.list!, ..._list];
        yield state.copyWith(list: li);
      }
    }
  }
}
