import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app_bloc/person/person_bloc.dart';
import 'package:movie_app_bloc/person/person_event.dart';
import 'package:movie_app_bloc/person/person_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;


class PersonsWidget extends StatefulWidget {
  const PersonsWidget({Key? key}) : super(key: key);

  @override
  _PersonsWidgetState createState() => _PersonsWidgetState();
}

class _PersonsWidgetState extends TeqWidgetState<PersonBloc, PersonsWidget> with BasePullToRefreshMixin<PersonsWidget> {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _handleAction(BuildContext context, PersonState state) {}

  @override
  PersonBloc createBloc() => PersonBloc();

  @override
  BaseBloc get refresherBloc => bloc;

  void _onLoadMore() async {
    bloc.add(PersonMoreEvent());
  }

  void _onRefresh() async {
    bloc.add(PersonEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => bloc..add(PersonEvent()))],
        child: BlocConsumer<PersonBloc, PersonState>(
          bloc: bloc,
          builder: _buildbody,
          listener: _handleAction,
        ));
  }
  Widget _buildbody(BuildContext context, PersonState state) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<PersonBloc, PersonState>(
      listener: (context, state) {
        if (!state.errorLoadMore) {
          _refreshController.loadComplete();
        }
        if (!state.errorRefresh) {
          _refreshController.refreshCompleted();
        }
      },
      child: BlocBuilder<PersonBloc, PersonState>(
          builder: (context, state) {
            if (state.list?.isNotEmpty == true) {
              return Container(
                color: Style.Colors.mainColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 20.0),
                      child: Text(
                        "TRENDING PERSONS ON THIS WEEK",
                        style: TextStyle(
                            color: Style.Colors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: size.height * 0.17,
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
                            return Container(
                              padding: EdgeInsets.only(top: 10.0, right: 8.0),
                              width: size.width * 0.25,
                              child: GestureDetector(
                                onTap: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    state.list![index].profileImg == null
                                        ? Hero(
                                      tag: state.list![index].id,
                                      child: Container(
                                        width: size.height * 0.3,
                                        height: size.width * 0.17,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Style.Colors.secondColor),
                                        child: Icon(
                                          FontAwesomeIcons.userAlt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                        : Hero(
                                      tag: state.list![index].id,
                                      child: Container(
                                          width: size.height * 0.3,
                                          height: size.width * 0.17,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://image.tmdb.org/t/p/w300/" +
                                                        state.list![index].profileImg)),
                                          )),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    Text(
                                      state.list![index].name,
                                      maxLines: 2,
                                      style: TextStyle(
                                          height: size.height * 0.001,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.009,
                                    ),
                                    Text(
                                      "Trending for " + state.list![index].known,
                                      maxLines: 2,
                                      style: TextStyle(
                                          height: size.height * 0.001,
                                          color: Style.Colors.titleColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9.0),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
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
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "No Persons",
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    )
                  ],
                ),
              );
            }
          }),
    );
  }

}
