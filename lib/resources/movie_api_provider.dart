import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uba_movieapp/models/item_model.dart';
import 'package:uba_movieapp/models/movie_detail.dart';



class MovieApiProvider {

  http.Client client = http.Client();
  final _apiKey = '9c9576f8c2e86949a3220fcc32ae2fb6';
  final _baseUrl = "https://api.themoviedb.org/3/movie";

  Future<ItemModel> fetchMovieList() async {
    final response = await client.get(Uri.parse("$_baseUrl/popular?api_key=$_apiKey"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      print("Inside 200 status code");
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      print("Status code : ${response.statusCode}");
       throw Exception('Failed to load movies list');
    } 
  }

  Future<MovieDetail> fetchMovieDetail(int movieId) async {
    final response = await client.get(Uri.parse("$_baseUrl/$movieId?api_key=$_apiKey"));
    print(response.body.toString());
    if(response.statusCode == 200) {
      return MovieDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to retrieve Movie Detail');
    }
  }

}