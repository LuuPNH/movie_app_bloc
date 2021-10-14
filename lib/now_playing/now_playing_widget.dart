import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_bloc/now_playing/now_playing_bloc.dart';
import 'package:movie_app_bloc/now_playing/now_playing_state.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;

class NowPlayingWidget extends StatefulWidget {
  const NowPlayingWidget({Key? key}) : super(key: key);

  @override
  _NowPlayingWidgetState createState() => _NowPlayingWidgetState();
}

class _NowPlayingWidgetState extends TeqWidgetState<NowPlayingBloc, NowPlayingWidget> with BasePullToRefreshMixin<NowPlayingWidget> {
  PageController pageController =
  PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => bloc)
        ],
        child: BlocConsumer<NowPlayingBloc, NowPlayingState> (
        bloc: bloc,
          builder:
          _buildbody,
          listener: _handleAction,
    ));
  }

  @override
  NowPlayingBloc createBloc() => NowPlayingBloc();

  @override
  // TODO: implement refresherBloc
  BaseBloc get refresherBloc => bloc;

  void _handleAction(BuildContext context, NowPlayingState state) {}

  Widget _buildbody(BuildContext context, NowPlayingState state) {
    Size size = MediaQuery.of(context).size ;
      return BlocBuilder<NowPlayingBloc, NowPlayingState>(
          builder: (context, state){
            if(state.list.isNotEmpty){
              return Container(
                color: Style.Colors.titleColor,
                height: size.height * 0.27,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  height: size.height * 0.27,
                  child: PageIndicatorContainer(
                    align: IndicatorAlign.bottom,
                    length: state.list.take(5).length,
                    indicatorSpace: size.width * 0.03,
                    padding: const EdgeInsets.all(5.0),
                    indicatorColor: Style.Colors.titleColor,
                    indicatorSelectorColor: Style.Colors.secondColor,
                    shape: IndicatorShape.circle(size: 5.0),
                    child: PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.list.take(5).length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Stack(
                            children: <Widget>[
                              Hero(
                                tag: state.list[index].id!,
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 220.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://image.tmdb.org/t/p/original/" +
                                                  state.list[index].backPoster!)),
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [
                                        0.0,
                                        0.9
                                      ],
                                      colors: [
                                        Style.Colors.mainColor.withOpacity(1.0),
                                        Style.Colors.mainColor.withOpacity(0.0)
                                      ]),
                                ),
                              ),
                              Positioned(
                                  bottom: 0.0,
                                  top: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: IconButton(
                                    icon: new Icon(
                                      FontAwesomeIcons.playCircle,
                                      color: Style.Colors.secondColor,
                                      size: size.height * 0.05,
                                    ),
                                    onPressed: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => MovieDetailScreen(
                                      //           movie: movies[index],
                                      //         )));
                                    },
                                  )),
                              Positioned(
                                  bottom: 20.0,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    width: size.width,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          state.list[index].title!,
                                          style: TextStyle(
                                              height: 1.5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

              );
            } else if(state.isLoading) {
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
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Can't load slide images"),
                    ],
                  ));
            }
          });
  }
}
