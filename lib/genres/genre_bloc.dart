import 'package:movie_app_bloc/genres/genre_state.dart';
import 'package:movie_app_bloc/repository/repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class GenreBloc extends BaseBloc<GenreState> {

  MovieRepository movieRepository = MovieRepository();

  GenreBloc() : super(GenreState(isLoading: true));

  @override
  Stream<GenreState> mapEventToState(BaseEvent event) async* {
    if(event is InitialEvent) {
      final list = await movieRepository.getGenres();
      yield state.copyWith(list: list);
    }
  }
}