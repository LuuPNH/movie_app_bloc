
import 'package:movie_app_bloc/now_playing/now_playing_state.dart';
import 'package:movie_app_bloc/repository/repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class NowPlayingBloc extends BaseBloc<NowPlayingState> {

  MovieRepository movieRepository = MovieRepository();

  NowPlayingBloc() : super(NowPlayingState(isLoading: true));

  @override
  Stream<NowPlayingState> mapEventToState(BaseEvent event) async* {
    if(event is InitialEvent) {
        final nowPlaying = await movieRepository.getPlayingMovies();
        yield state.copyWith(list: nowPlaying);
    }
  }
}