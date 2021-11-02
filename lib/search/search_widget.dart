import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_bloc/screen/home/home_screen.dart';
import 'package:movie_app_bloc/style/inputfiled.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/screen/detail/detail_screen.dart';
import 'package:movie_app_bloc/search/search_bloc.dart';
import 'package:movie_app_bloc/search/search_event.dart';
import 'package:movie_app_bloc/search/search_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'dart:async';

class SearchMoviesWidget extends StatefulWidget {
  const SearchMoviesWidget({Key? key}) : super(key: key);

  @override
  _SearchMoviesWidgetState createState() => _SearchMoviesWidgetState();
}

class _SearchMoviesWidgetState
    extends State<SearchMoviesWidget>
    with AutomaticKeepAliveClientMixin<SearchMoviesWidget> {
  TextEditingController textEditingController = TextEditingController();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Timer? debounce;
  bool isFirstSearch = true;

  void _onSearchChanged(String query) async {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () async {
      if (textEditingController.text.isEmpty == false) {
        isFirstSearch = false;
        SearchMovieBloc().add(SearchMovieEvent(textEditingController.text));
      } else if (textEditingController.text.isEmpty) {
        isFirstSearch = true;
        SearchMovieBloc().add(SearchMovieEvent("khongcogi"));
      }
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Column(children: [
            TextFieldContainer(
              color: Style.Colors.titleColor,
              child: TextField(
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
                onChanged: _onSearchChanged,
                controller: textEditingController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    EvaIcons.searchOutline,
                    color: Style.Colors.secondColor,
                  ),
                  hintText: 'Enter Your Name',
                  hintStyle: TextStyle(
                      color: Style.Colors.secondColor,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                  border: InputBorder.none,
                ),
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 5.0,
        ),
        BlocListener<SearchMovieBloc, SearchMovieState>(
          listener: (context, state) {
            if (!state.errorLoadmore) {
              _refreshController.loadComplete();
            }
            if (!state.errorRefresh) {
              _refreshController.refreshCompleted();
            }
          },
          child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
              builder: (context, state) {
                if (state.list?.isNotEmpty == true) {
                  return Expanded(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      footer: CustomFooter(
                        builder: (BuildContext context, LoadStatus? mode) {
                          Widget body;
                          if (mode == LoadStatus.idle) {
                            body = Text(
                              "more ...",
                              style: TextStyle(color: Colors.white),
                            );
                          } else if (mode == LoadStatus.loading) {
                            body = Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Loading...",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 12.0,
                                  width: 12.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ],
                            );
                          } else if (mode == LoadStatus.failed) {
                            body = Text("Load Failed!Click retry!");
                          } else if (mode == LoadStatus.canLoading) {
                            body = Text("release to load more");
                          } else {
                            body = Text("No more Data");
                          }
                          return Container(
                            height: 30.0,
                            child: Center(child: body),
                          );
                        },
                      ),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoadMore,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: state.list!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(top: 10.0, right: 8.0),
                            width: 100.0,
                            child: GestureDetector(
                              onTap: () async {
                                // Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailMovieScreen(
                                          movie: state.list![index],
                                        )));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  state.list![index].backPoster == null
                                      ? Hero(
                                    tag: state.list![index].id!,
                                    child: Container(
                                      margin:
                                      EdgeInsets.only(left: 25.0, top: 10.0),
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Style.Colors.secondColor),
                                      child: Icon(
                                        FontAwesomeIcons.userAlt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                      : Hero(
                                    tag: state.list![index].id!,
                                    child: Container(
                                        margin: EdgeInsets.only(left: 25.0),
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://image.tmdb.org/t/p/w300/" +
                                                      state.list![index]
                                                          .backPoster!)),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 25.0),
                                      child: Text(
                                        state.list![index].title!,
                                        maxLines: 2,
                                        style: TextStyle(
                                            height: 1.4,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.0,
                                  ),
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
                      color: Style.Colors.mainColor,
                      child: Center(
                          child: Text("What is your find?",
                              style: TextStyle(
                                  color: Style.Colors.text,
                                  fontWeight: FontWeight.bold))));
                } else {
                  return Container(
                      color: Style.Colors.mainColor,
                      child: Center(
                          child: Text("No movies this name",
                              style: TextStyle(
                                  color: Style.Colors.text,
                                  fontWeight: FontWeight.bold))));
                }
              }),
        ),
      ],
    );
  }


  void _onLoadMore() async {
    SearchMovieBloc().add(SearchMovieMoreEvent(textEditingController.text));
  }

  void _onRefresh() async {
    SearchMovieBloc().add(SearchMovieEvent(textEditingController.text));
  }

  // Widget _buildbody() {
  //   Size size = MediaQuery.of(context).size;
  //   return ;
  // }


  @override
  bool get wantKeepAlive => true;
}
