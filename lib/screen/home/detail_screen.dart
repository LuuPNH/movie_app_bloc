import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app_bloc/model/movie/movie.dart';
import 'package:movie_app_bloc/style/theme.dart' as Style;

class DetailMovieScreen extends StatefulWidget {
  final Movie movie;

  const DetailMovieScreen({Key? key, required this.movie}) : super(key: key);



  @override
  _DetailMovieScreenState createState() => _DetailMovieScreenState(movie);
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  final Movie movie;

  _DetailMovieScreenState(this.movie);

  @override
  Widget build(BuildContext context) {
    bool _pinned = true;
    bool _snap = false;
    bool _floating = false;
    return Scaffold(
        backgroundColor: Style.Colors.mainColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              backgroundColor: Style.Colors.mainColor,
              expandedHeight: 200.0,
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.0),
                  child: Transform.translate(
                    offset: const Offset(150, 30),
                    child: Container(height: 100.0, color: Colors.white,),
                  )),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  movie.title!,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis
                  ),
                ),
                background: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/original/" +
                                      movie.backPoster!))),
                      child: Container(
                        decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.3)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.0)
                              ])),
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
                padding: EdgeInsets.all(0.0),
                sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                (movie.rating! / 2).toString().substring(0, 3),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              RatingBar.builder(
                                itemSize: 10.0,
                                initialRating: movie.rating! / 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => Icon(
                                  EvaIcons.star,
                                  color: Style.Colors.secondColor,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Text(
                            "OVERVIEW",
                            style: TextStyle(
                                color: Style.Colors.titleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            movie.overview!,
                            style: TextStyle(
                                color: Colors.white, fontSize: 12.0, height: 1.5),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        // MovieInfo(
                        //   id: movie.id!,
                        // ),
                        // SimilarMovies(
                        //   id: movie.id!,
                        // )
                      ],
                    )))
          ],
        ));
  }
}
