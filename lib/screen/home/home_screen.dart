import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/authentication/authen_bloc.dart';
import 'package:movie_app_bloc/authentication/authen_event.dart';
import 'package:movie_app_bloc/authentication/authen_state.dart';
import 'package:movie_app_bloc/authentication/authen_widget.dart';
import 'package:movie_app_bloc/genres/genre_widget.dart';
import 'package:movie_app_bloc/now_playing/now_playing_widget.dart';
import 'package:movie_app_bloc/person/person_widget.dart';
import 'package:movie_app_bloc/popular/popular_widget.dart';
import 'package:movie_app_bloc/search/search_widget.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import '../../style/theme.dart' as Style;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    ListView(children: [
      NowPlayingWidget(),
      GenresWidget(),
      PersonsWidget(),
      PopularMovieWidget(),
    ]),

    AuthenWidget()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              onPressed: _openEndDrawer,
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
      endDrawer: Drawer(
        child: SafeArea(
          child: Container(
            color: Style.Colors.mainColor,
            padding: EdgeInsets.all(16),
            child: SearchMoviesWidget(),
          ),
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
      body: Container(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Information',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Style.Colors.secondColor,
        onTap: _onItemTapped,
      ),
    );
  }

}
