import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:uba_movieapp/models/item_model.dart';
import 'package:uba_movieapp/models/movie_detail.dart';
import 'package:uba_movieapp/resources/repository.dart';

class MovieDetailBloc {

  final _repository = Repository();
  final _movieId = BehaviorSubject<int>();
  // ignore: close_sinks
  final _similarMovies = BehaviorSubject<Future<ItemModel>>();
  // ignore: close_sinks
  final _movieDetail = BehaviorSubject<Future<MovieDetail>>();

  Function(int) get fetchTrailersById => _movieId.sink.add;

  Function(int) get fetchSimilarMoviesById => _movieId.sink.add;
  BehaviorSubject<Future<ItemModel>> get similarMovies => _similarMovies.stream;

  Function(int) get fetchMovieDetailById => _movieId.sink.add;
  BehaviorSubject<Future<MovieDetail>> get movieDetail => _movieDetail.stream;


  MovieDetailBloc() {
    _movieId.stream.transform(_movieDetailTransformer()).pipe(_movieDetail);
  }

  dispose() async {
    _movieId?.close();
  }


  _movieDetailTransformer() {
    return ScanStreamTransformer(
      (Future<MovieDetail> movieDetail, int id, int index) {
        print("MOVIE ID : $id");
        movieDetail =_repository.fetchMovieDetail(id);
        return movieDetail;
      },
    );
  }

}