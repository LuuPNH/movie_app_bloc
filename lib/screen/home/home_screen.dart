import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_bloc/genres/genre_widget.dart';
import 'package:movie_app_bloc/now_playing/now_playing_widget.dart';
import 'package:movie_app_bloc/person/person_widget.dart';
import 'package:movie_app_bloc/popular/popular_widget.dart';
import '../../style/theme.dart' as Style;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        title: Text("Movie App"),
        actions: <Widget>[
          IconButton(
              onPressed: null,
              icon: Icon(
                EvaIcons.searchOutline,
                color: Colors.white,
              )),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          NowPlayingWidget(),
          GenresWidget(),
          PersonsWidget(),
          PopularMovieWidget(),
        ],
      ),
    );
  }
}
