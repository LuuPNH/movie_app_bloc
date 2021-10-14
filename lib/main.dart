import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/now_playing/now_playing_widget.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;
import 'package:movie_app_bloc/utils/simple_bloc_obsever.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
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
              onPressed: () {
              },
            )
          ],
        ),
        body: NowPlayingWidget(),
      )
    );
  }
}

