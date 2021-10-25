import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_bloc/authentication/authen_widget.dart';
import 'package:movie_app_bloc/genres/genre_widget.dart';
import 'package:movie_app_bloc/now_playing/now_playing_widget.dart';
import 'package:movie_app_bloc/person/person_widget.dart';
import 'package:movie_app_bloc/popular/popular_widget.dart';
import 'package:movie_app_bloc/search/search_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../style/theme.dart' as Style;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  static RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Widget> widgetOptions = <Widget>[home(), AuthenWidget()];
  static List<Widget> homelist = <Widget>[
    NowPlayingWidget(),
    GenresWidget(),
    PersonsWidget(),
    PopularMovieWidget(),
  ];

  void _reload() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomeScreen(),
        ),
      );
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  static void _onRefresh() async {
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static Widget home() {
    print("checklength");
    print(homelist.length);
    return Container(
      color: Style.Colors.mainColor,
      child: SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(
          refreshingIcon: SizedBox(
            height: 20.0,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Style.Colors.secondColor,
            ),
          ),
          refreshingText: "",
          releaseText: "",
          completeText: "",
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: homelist.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (c, i) {
            return ListBody(
              children: [
                homelist[i],
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            onPressed: _reload,
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
