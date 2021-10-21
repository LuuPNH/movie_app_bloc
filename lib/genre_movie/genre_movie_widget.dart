import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app_bloc/genre_movie/genre_movie_bloc.dart';
import 'package:movie_app_bloc/genre_movie/genre_movie_event.dart';
import 'package:movie_app_bloc/genre_movie/genre_movie_state.dart';
import 'package:movie_app_bloc/screen/detail/detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;

class GenreMoviesWidget extends StatefulWidget {
  final int genreId;

  const GenreMoviesWidget({Key? key, required this.genreId}) : super(key: key);

  @override
  _GenreMoviesWidgetState createState() => _GenreMoviesWidgetState(genreId);
}

class _GenreMoviesWidgetState
    extends TeqWidgetState<GenreMovieBloc, GenreMoviesWidget>
    with BasePullToRefreshMixin<GenreMoviesWidget> {
  final int genreId;

  _GenreMoviesWidgetState(this.genreId);

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int page = 1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => bloc..add(GenresMovieEvent(genreId, 1)))
        ],
        child: BlocConsumer<GenreMovieBloc, GenreMovieState>(
          bloc: bloc,
          builder: _buildbody,
          listener: _handleAction,
        ));
  }

  void _handleAction(BuildContext context, GenreMovieState state) {}

  @override
  GenreMovieBloc createBloc() => GenreMovieBloc();

  @override
  BaseBloc get refresherBloc => bloc;

  void _onLoadMore() async {
    await Future.delayed(Duration(milliseconds: 500));
    page += 1;
    bloc.add(GenresMovieMoreEvent(genreId, page));
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    page = 1;
    bloc.add(GenresMovieEvent(genreId, page));
    _refreshController.refreshCompleted();
  }

  Widget _buildbody(BuildContext context, GenreMovieState state) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GenreMovieBloc, GenreMovieState>(
        builder: (context, state) {
      if (state.list?.isNotEmpty == true) {
        return Container(
          height: size.height * 0.4,
          padding: EdgeInsets.only(left: 10.0),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: ClassicHeader(
              refreshingIcon: SizedBox(
                height: size.height * 0.02,
                width: size.width * 0.04,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Style.Colors.secondColor,
                ),
              ),
              refreshingText: "",
              releaseText: "",
              completeText: "",
            ),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                print(mode);
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text(
                    "",
                    style: TextStyle(color: Colors.white),
                  );
                } else if (mode == LoadStatus.loading) {
                  body = SizedBox(
                    height: size.height * 0.02,
                    width: size.width * 0.04,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Style.Colors.secondColor,
                    ),
                  );
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed! Scroll retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: size.height * 0.4,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoadMore,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.list!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailMovieScreen(
                                  movie: state.list![index],
                                )));
                      },
                      child: Column(
                        children: [
                          state.list![index].poster == null
                              ? Container(
                                  width: size.width * 0.2,
                                  height: size.height * 0.4,
                                  decoration: BoxDecoration(
                                      color: Style.Colors.secondColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2.0)),
                                      shape: BoxShape.rectangle),
                                  child: Column(
                                    children: [
                                      Icon(
                                        EvaIcons.filmOutline,
                                        color: Colors.white,
                                        size: 50.0,
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  width: size.width * 0.32,
                                  height: size.height * 0.23,
                                  decoration: BoxDecoration(
                                    color: Style.Colors.secondColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3.0)),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w200" +
                                                state.list![index].poster!),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                          SizedBox(
                            height: size.height * 0.002,
                          ),
                          Expanded(
                            child: Container(
                              width: size.height * 0.15,
                              child: Text(
                                state.list![index].title!,
                                maxLines: 2,
                                style: TextStyle(
                                  height: size.height * 0.002,
                                  color: Colors.white,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          Row(
                            children: [
                              Text(
                                (state.list![index].rating! / 2)
                                    .toString()
                                    .substring(0, 3),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: size.width * 0.005,
                              ),
                              RatingBar.builder(
                                itemSize: size.width * 0.03,
                                initialRating: state.list![index].rating! / 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.003),
                                itemBuilder: (context, _) => Icon(
                                  EvaIcons.star,
                                  color: Style.Colors.secondColor,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        );
      } else if (state.isLoading) {
        return Container(
          color: Colors.green,
          height: 30.0,
          width: 20.0,
        );
      } else {
        return Container(
          color: Style.Colors.mainColor,
          height: 30.0,
          width: 20.0,
          child: Text(
            "No movies",
            style: TextStyle(
                color: Style.Colors.text, fontWeight: FontWeight.bold),
          ),
        );
      }
    });
  }
}
