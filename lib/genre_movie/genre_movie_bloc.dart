import 'package:movie_app_bloc/genre_movie/genre_movie_event.dart';
import 'package:movie_app_bloc/genre_movie/genre_movie_state.dart';
import 'package:movie_app_bloc/model/movie/movie.dart';
import 'package:movie_app_bloc/repository/repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class GenreMovieBloc extends BaseBloc<GenreMovieState> {
  GenreMovieBloc() : super(GenreMovieState(isLoading: true));

  MovieRepository movieRepository = MovieRepository();

  @override
  Stream<GenreMovieState> mapEventToState(BaseEvent event) async* {
    if (event is GenresMovieEvent) {
      var list = await movieRepository.getMovieByGenre(event.id, state.page);
      yield state.copyWith(list: list, page: state.page + 1);
    }
    if (event is GenresMovieMoreEvent) {
      List<Movie>? li;
      if (state.list?.isNotEmpty == true) {
        List<Movie>? _list =
            await movieRepository.getMovieByGenre(event.id, state.page);
        li = [...state.list!, ..._list];
        yield state.copyWith(list: li,page: state.page + 1);
      }
    }
  }
}
