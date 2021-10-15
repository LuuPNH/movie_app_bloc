import 'package:movie_app_bloc/genre_movie/genre_movie_event.dart';
import 'package:movie_app_bloc/genre_movie/genre_movie_state.dart';
import 'package:movie_app_bloc/model/movie.dart';
import 'package:movie_app_bloc/repository/repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

 class GenreMovieBloc extends BaseBloc<GenreMovieState> {

  final int id;
  final int? page;

  GenreMovieBloc(this.id, this.page) : super(GenreMovieState(id: id, page: page ?? 1));

  MovieRepository movieRepository = MovieRepository();
  List<Movie> list = [];

  @override
  Stream<GenreMovieState> mapEventToState(BaseEvent event) async* {
    if (event is InitialEvent) {
      list = await movieRepository.getMovieByGenre(id, page!);
      yield state.copyWith(list: list);
    } if(event is GenreMovieDataMoreEvent) {
      var li = await movieRepository.getMovieByGenre(event.id, event.pageKey);
    }
  }
}
