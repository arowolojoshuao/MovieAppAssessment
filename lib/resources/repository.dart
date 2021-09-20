import 'package:uba_movieapp/models/item_model.dart';
import 'package:uba_movieapp/models/movie_detail.dart';
import 'movie_api_provider.dart';
import 'dart:async';


class Repository {

  final MovieApiProvider _movieApiProvider = MovieApiProvider();

  Future<ItemModel> fetchMoviesList() => _movieApiProvider.fetchMovieList();
  Future<MovieDetail> fetchMovieDetail(int movieId) => _movieApiProvider.fetchMovieDetail(movieId);
  

}