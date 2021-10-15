import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/genre_movie/genre_movie_bloc.dart';
import 'package:movie_app_bloc/genre_movie/genre_movie_event.dart';
import 'package:movie_app_bloc/genre_movie/genre_movie_widget.dart';
import 'package:movie_app_bloc/genres/genre_bloc.dart';
import 'package:movie_app_bloc/genres/genre_state.dart';
import 'package:movie_app_bloc/model/genre/genre.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;

class GenresWidget extends StatefulWidget {
  const GenresWidget({Key? key}) : super(key: key);

  @override
  _GenresWidgetState createState() => _GenresWidgetState();
}

class _GenresWidgetState extends TeqWidgetState<GenreBloc, GenresWidget> with BasePullToRefreshMixin<GenresWidget>{
   TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => bloc)
        ],
        child: BlocConsumer<GenreBloc, GenreState> (
          bloc: bloc,
          builder: _buildbody,
          listener: _handleAction,
        ));
  }

  void _handleAction(BuildContext context, GenreState state) {}

  @override
  GenreBloc createBloc() => GenreBloc();

  @override
  // TODO: implement refresherBloc
  BaseBloc get refresherBloc => bloc;

  Widget _buildbody(BuildContext context, GenreState state) {
    Size size = MediaQuery.of(context).size ;
    return BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          if(state.list.isNotEmpty){
            return Container(
              height: size.height * 0.4,
              child: DefaultTabController(
                length: state.list.length,
                child: Scaffold(
                  backgroundColor: Style.Colors.mainColor,
                  appBar: PreferredSize(
                      child: AppBar(
                        backgroundColor: Style.Colors.mainColor,
                        bottom: TabBar(
                            //controller: _tabController,
                            indicatorColor: Style.Colors.secondColor,
                            indicatorWeight: 3.0,
                            unselectedLabelColor: Style.Colors.titleColor,
                            labelColor: Colors.white,
                            isScrollable: true,
                            tabs: state.list.map((Genre genre) {
                              return Container(
                                padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                                child: Text(
                                  genre.name!.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 14.0, fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList()),
                      ),
                      preferredSize: Size.fromHeight(50)),
                  body: TabBarView(
                      controller: _tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: state.list.map((Genre genre) {
                        return BlocProvider(
                            create: (context) => GenreMovieBloc(),
                            child: GenreMoviesWidget(genreId: genre.id));
                      }).toList(),
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
                    Text("Can't load list genres"),
                  ],
                ));
          }
        }
    );
  }
}
