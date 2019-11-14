import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_apps/blocs/movie_trailer_bloc.dart';
import 'package:flutter_apps/blocs/movie_trailer_provider_bloc.dart';
import 'package:flutter_apps/models/m_trailer_movie.dart';
import 'package:flutter_apps/utility/sharedpreferences.dart';

class DetailMovie extends StatefulWidget {
  final String imageMovie;
  final String titleMovie;
  final String descMovie;
  final String synopsisMovie;

  final int movieId;
  final String backdropImage;

  @override
  State<StatefulWidget> createState() {
    return DetailMovieState();
  }

  //Constructor DetailMovie
  DetailMovie(
      {this.imageMovie,
      this.titleMovie,
      this.descMovie,
      this.synopsisMovie,
      this.movieId,
      this.backdropImage});
}

class DetailMovieState extends State<DetailMovie> {
  MovieTrailerBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = MovieTrailerBlocProvider.of(context);
    bloc.fetchTrailerById(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            top: false,
            bottom: false,
            child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBox) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(Icons.exit_to_app),
                            onPressed: () => logOut(),
                          ),
                        )
                      ],
                      elevation: 0.0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                            "http://image.tmdb.org/t/p/w500${widget.backdropImage}"),
                      ),
                    )
                  ];
                },
                body: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          widget.titleMovie,
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.descMovie),
                        Text("Trailer",
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold)),
                        StreamBuilder(
                          builder: (context,
                              AsyncSnapshot<Future<TrailerMovieModel>>
                                  snapshot) {
                            return FutureBuilder(
                              builder: (context,
                                  AsyncSnapshot<TrailerMovieModel>
                                      itemSnapshot) {
                                if (itemSnapshot.hasData) {
                                  //Check Trailer ada apa enggak?
                                  if (itemSnapshot.data.results.length > 0) {
                                    //Jika trailernya ada
                                    return trailerLayout(itemSnapshot.data);
                                  } else {
                                    //Jika trailernya tidak ada
                                    return noTrailer();
                                  }
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                              future: snapshot.data,
                            );
                          },
                          stream: bloc.movieTrailers,
                        )
                      ],
                    ),
                  ],
                ))));
  }

  //Jika Tidak ada Trailer
  Widget noTrailer() {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  //Jika ada Trailer
  Widget trailerLayout(TrailerMovieModel data) {
    if (data.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
          trailerItem(data, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerMovieModel data, int index) {
    return Expanded(
        child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5.0),
          height: 100,
          color: Colors.grey,
          child: Center(
            child: IconButton(
                icon: Icon(Icons.play_circle_filled), onPressed: () => {}),
          ),
        ),
        Text(
          data.results[index].name,
          maxLines: 1,
        )
      ],
    ));
  }

  logOut() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout'),
            content: Text('Apakah anda yakin ingin logout?'),
            actions: <Widget>[
              RaisedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton(
                onPressed: () => actionLogout(),
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  actionLogout() {
    SharedPreferencesHelper.clearAllPreference().then((onValue) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
    });
  }
}
