import 'package:rxdart/rxdart.dart';
import 'package:uba_movieapp/models/item_model.dart';
import 'package:uba_movieapp/resources/repository.dart';

class MoviesBloc {

  final _repository = Repository();
  final _moviesFetcher = BehaviorSubject<ItemModel>();

  BehaviorSubject<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchMoviesList();
    _moviesFetcher.sink.add(itemModel); 
  }

  dispose() {
    _moviesFetcher?.close();
  }
}
final bloc = MoviesBloc();