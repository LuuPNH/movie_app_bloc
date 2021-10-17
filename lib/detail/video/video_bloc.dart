import 'package:movie_app_bloc/detail/video/video_event.dart';
import 'package:movie_app_bloc/detail/video/video_state.dart';
import 'package:movie_app_bloc/repository/repository.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class VideoBloc extends BaseBloc<VideoState> {

  MovieRepository movieRepository = MovieRepository();

  VideoBloc() : super(VideoState(isLoading: true));

  @override
  Stream<VideoState> mapEventToState(BaseEvent event) async* {
    if(event is VideoGetDataEvent) {
      final item = await movieRepository.getVideo(event.id);
      yield state.copyWith(item: item);
    }
  }
}