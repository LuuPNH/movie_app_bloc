import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/detail/info/movie_detail_bloc.dart';
import 'package:movie_app_bloc/detail/info/movie_detail_event.dart';
import 'package:movie_app_bloc/detail/info/movie_detail_state.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;
import 'package:teq_flutter_core/teq_flutter_core.dart';

class MovieInfoWidget extends StatefulWidget {
  final int id;
  const MovieInfoWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _MovieInfoWidgetState createState() => _MovieInfoWidgetState(id);
}

class _MovieInfoWidgetState extends TeqWidgetState<MovieDetailBloc, MovieInfoWidget>
    with BasePullToRefreshMixin<MovieInfoWidget>  {
  final int id;

  _MovieInfoWidgetState(this.id);




  void _handleAction(BuildContext context, MovieDetailState state) {}

  @override
  MovieDetailBloc createBloc() => MovieDetailBloc();

  @override
  // TODO: implement refresherBloc
  BaseBloc get refresherBloc => bloc;


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => bloc..add(MovieDetailGetDataEvent(id)))],
        child: BlocConsumer<MovieDetailBloc, MovieDetailState>(
          bloc: bloc,
          builder: _buildbody,
          listener: _handleAction,
        ));
  }

  Widget _buildbody(BuildContext context, MovieDetailState state) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(builder: (context, state) {
      if (state.item != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "BUDGET",
                        style: TextStyle(
                            color: Style.Colors.titleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        state.item!.budget.toString() + "\$",
                        style: TextStyle(
                            color: Style.Colors.secondColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "DURATION",
                        style: TextStyle(
                            color: Style.Colors.titleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(state.item!.runtime.toString() + "min",
                          style: TextStyle(
                              color: Style.Colors.secondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "RELEASE DATE",
                        style: TextStyle(
                            color: Style.Colors.titleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(state.item!.releaseDate,
                          style: TextStyle(
                              color: Style.Colors.secondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "GENRES",
                    style: TextStyle(
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 38.0,
                    padding: EdgeInsets.only(right: 10.0, top: 10.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.item!.genres.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                                border:
                                Border.all(width: 1.0, color: Colors.white)),
                            child: Text(
                              state.item!.genres[index].name ?? "No name",
                              maxLines: 2,
                              style: TextStyle(
                                  height: 1.4,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.0),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        );
      } else if (state.isLoading) {
        return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ));
      } else {
        return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Errorr"),
              ],
            ));
      }
    });
  }

}
