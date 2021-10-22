import 'package:movie_app_bloc/model/movie/movie.dart';
import 'package:movie_app_bloc/repository/repository.dart';
import 'package:movie_app_bloc/search/search_event.dart';
import 'package:movie_app_bloc/search/search_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class SearchMovieBloc extends BaseBloc<SearchMovieState> {
  SearchMovieBloc() : super(SearchMovieState(isLoading: true, ));

  MovieRepository movieRepository = MovieRepository();
  int pageKey = 1;

  @override
  Stream<SearchMovieState> mapEventToState(BaseEvent event) async* {
    if (event is SearchMovieEvent) {
      pageKey = 1;
      var list =
          await movieRepository.getSearchMovies(event.name, pageKey);
      if(list.isEmpty){
        yield state.copyWith(errorRefresh: true);
      }
      yield state.copyWith(list: list,errorRefresh: false);
    } else if (event is SearchMovieMoreEvent) {
      List<Movie>? li;
      if (state.list?.isNotEmpty == true) {
        pageKey += 1;
        List<Movie>? _list =
            await movieRepository.getSearchMovies(event.name, pageKey);
        if(_list.isEmpty == true){
          yield state.copyWith(errorLoadmore: true);
        }
        li = [...state.list!, ..._list];
        yield state.copyWith(list: li);
      }
    } else if (event is SearchMovieStartEvent) {
      yield state.copyWith(isFirstLoad: true);
    }
  }
}
