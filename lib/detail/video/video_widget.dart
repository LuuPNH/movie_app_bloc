import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/detail/video/video_bloc.dart';
import 'package:movie_app_bloc/detail/video/video_event.dart';
import 'package:movie_app_bloc/detail/video/video_state.dart';
import 'package:movie_app_bloc/model/movie/movie.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  final Movie movie;

  const VideoWidget({Key? key, required this.movie}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState(movie);
}

class _VideoWidgetState extends TeqWidgetState<VideoBloc, VideoWidget>
    with BasePullToRefreshMixin<VideoWidget>  {
  final Movie movie;

  _VideoWidgetState(this.movie);


  void _handleAction(BuildContext context, VideoState state) {}

  @override
  VideoBloc createBloc() => VideoBloc();

  @override
  // TODO: implement refresherBloc
  BaseBloc get refresherBloc => bloc;


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => bloc..add(VideoGetDataEvent(movie.id!)))],
        child: BlocConsumer<VideoBloc, VideoState>(
          bloc: bloc,
          builder: _buildbody,
          listener: _handleAction,
        ));
  }

  Widget _buildbody(BuildContext context, VideoState state) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
      if (state.item != null) {
        return Container(
          child: FloatingActionButton(
            backgroundColor: Style.Colors.secondColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                    controller: YoutubePlayerController(
                      initialVideoId: state.item!.key,
                      flags: YoutubePlayerFlags(
                        autoPlay: true,
                        mute: true,
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Icon(Icons.play_arrow),
          ),
        );
      } else if (state.isLoading) {
        return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 4.0,
                  ),
                )
              ],
            ));
      } else {
        return FloatingActionButton(
          backgroundColor: Style.Colors.secondColor,
          onPressed: () {},
          child: Icon(Icons.error),
        );
      }
    });
  }
}
class VideoPlayerScreen extends StatefulWidget {
  final YoutubePlayerController controller;
  VideoPlayerScreen({Key? key, required this.controller}) : super(key: key);
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState(controller);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final YoutubePlayerController controller;

  _VideoPlayerScreenState(this.controller);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Center(
              child: YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: true,
              ),
            ),
            Positioned(
              top: 40.0,
              right: 20.0,
              child: IconButton(
                  icon: Icon(
                    EvaIcons.closeCircle,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            )
          ],
        ));
  }
}
