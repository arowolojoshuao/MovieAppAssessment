import 'package:flutter/material.dart';
import 'package:uba_movieapp/blocs/movie/movie_detail_bloc.dart';


class MovieBlocProvider extends InheritedWidget {
  final MovieDetailBloc bloc;
  MovieBlocProvider({Key key, Widget child}) :bloc = MovieDetailBloc(), super(key:key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }


  static MovieDetailBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<MovieBlocProvider>()).bloc;
  }

}