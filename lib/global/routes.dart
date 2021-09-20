import 'package:flutter/material.dart';
import 'package:uba_movieapp/global/uidata.dart';
import 'package:uba_movieapp/screens/login_page.dart';
import 'package:uba_movieapp/screens/movies/movie_detail.dart';
import 'package:uba_movieapp/screens/movies/movie_list.dart';


final routes = <String, WidgetBuilder>{
  UiData.sign_in: (BuildContext context) =>  LoginScreen(),
  UiData.movieList: (BuildContext context) =>  MovieListScreen(),
  UiData.movieDetails: (BuildContext context) =>  MovieDetailScreen(),
};
