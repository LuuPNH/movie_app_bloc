import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app_bloc/detail/similar/similar_bloc.dart';
import 'package:movie_app_bloc/detail/similar/similar_event.dart';
import 'package:movie_app_bloc/detail/similar/similar_state.dart';
import 'package:movie_app_bloc/screen/home/detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;

class SimilarMovieWidget extends StatefulWidget {
  final int id;

  const SimilarMovieWidget({Key? key, required this.id}) : super(key: key);

  @override
  _SimilarMovieWidgetState createState() => _SimilarMovieWidgetState(id);
}

class _SimilarMovieWidgetState
    extends TeqWidgetState<SimilarMovieBloc, SimilarMovieWidget>
    with BasePullToRefreshMixin<SimilarMovieWidget> {
  final int id;

  _SimilarMovieWidgetState(this.id);

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int page = 1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => bloc..add(SimilarMovieEvent(id, 1)))
        ],
        child: BlocConsumer<SimilarMovieBloc, SimilarMovieState>(
          bloc: bloc,
          builder: _buildbody,
          listener: _handleAction,
        ));
  }

  void _handleAction(BuildContext context, SimilarMovieState state) {}

  @override
  SimilarMovieBloc createBloc() => SimilarMovieBloc();

  @override
  BaseBloc get refresherBloc => bloc;

  void _onLoadMore() async {
    await Future.delayed(Duration(milliseconds: 500));
    page += 1;
    bloc.add(SimilarMovieMoreEvent(id, page));
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    page = 1;
    bloc.add(SimilarMovieEvent(id, page));
    _refreshController.refreshCompleted();
  }

  Widget _buildbody(BuildContext context, SimilarMovieState state) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "SIMILAR MOVIES",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        BlocBuilder<SimilarMovieBloc, SimilarMovieState>(
            builder: (context, state) {
          if (state.list?.isNotEmpty == true) {
            return Container(
              height: 270.0,
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
                      height: 200,
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
                          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Hero(
                              tag: state.list![index].id!,
                              child: Container(
                                  width: 120.0,
                                  height: 180.0,
                                  decoration: new BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2.0)),
                                    shape: BoxShape.rectangle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w200/" +
                                                state.list![index].poster!)),
                                  )),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                state.list![index].title!,
                                maxLines: 2,
                                style: TextStyle(
                                    height: 1.4,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
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
                                  width: 5.0,
                                ),
                                RatingBar.builder(
                                  itemSize: 8.0,
                                  initialRating: state.list![index].rating! / 2,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  itemBuilder: (context, _) => Icon(
                                    EvaIcons.star,
                                    color: Style.Colors.secondColor,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
        }),
      ],
    );
  }
}