import 'package:movie_app_bloc/model/movie/movie.dart';
import 'package:movie_app_bloc/repository/repository.dart';
import 'package:movie_app_bloc/search/search_event.dart';
import 'package:movie_app_bloc/search/search_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class SearchMovieBloc extends BaseBloc<SearchMovieState> {
  SearchMovieBloc() : super(SearchMovieState(isLoading: true));

  MovieRepository movieRepository = MovieRepository();

  @override
  Stream<SearchMovieState> mapEventToState(BaseEvent event) async* {
    if (event is SearchMovieEvent) {
      var list = await movieRepository.getSearchMovies(event.name, event.pageKey);
      yield state.copyWith(list: list);
    }
    else if (event is SearchMovieMoreEvent) {
      List<Movie>? li;
      if (state.list?.isNotEmpty == true) {
        List<Movie>? _list =
        await movieRepository.getSearchMovies(event.name, event.pageKey);
        li = [...state.list!, ..._list];
        yield state.copyWith(list: li);
      }
    } else if (event is SearchMovieStartEvent) {
      yield state.copyWith(isFirstLoad: true);
    }
  }
}