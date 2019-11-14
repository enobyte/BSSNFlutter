import 'package:flutter/material.dart';
import 'package:flutter_apps/blocs/movie_trailer_bloc.dart';

class MovieTrailerBlocProvider extends InheritedWidget {
  final MovieTrailerBloc bloc;

  MovieTrailerBlocProvider({Key key, Widget child})
      : bloc = MovieTrailerBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static MovieTrailerBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(
        MovieTrailerBlocProvider) as MovieTrailerBlocProvider).bloc;
  }
}
