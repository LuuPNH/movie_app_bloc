

import 'package:movie_app_bloc/detail/info/movie_detail_event.dart';
import 'package:movie_app_bloc/detail/info/movie_detail_state.dart';
import 'package:movie_app_bloc/repository/repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class MovieDetailBloc extends BaseBloc<MovieDetailState> {

  MovieRepository movieRepository = MovieRepository();

  MovieDetailBloc() : super(MovieDetailState(isLoading: true));

  @override
  Stream<MovieDetailState> mapEventToState(BaseEvent event) async* {
    if(event is MovieDetailGetDataEvent) {
      final item = await movieRepository.getMovie(event.id);
      yield state.copyWith(item: item);
    }
  }
}