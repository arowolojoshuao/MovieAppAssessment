import 'package:flutter/material.dart';
import 'package:uba_movieapp/models/item_model.dart';
import 'package:uba_movieapp/blocs/movie/movie_detail_bloc_provider.dart';
import 'package:uba_movieapp/blocs/movie/movies_bloc.dart';
import 'package:uba_movieapp/screens/movies/movie_detail.dart';

class MovieListScreen extends StatefulWidget {
  @override
  MovieListScreenState createState() {
    return new MovieListScreenState();
  }
}

class MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Movies',style: TextStyle(color: Colors.blueGrey),),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            print("Inside hasError");
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: InkResponse(
            splashColor: Colors.red,
            enableFeedback: true,
            child: Image.network(
              'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
              fit: BoxFit.cover,
            ),
            onTap: () => goToMoviesDetailPage(snapshot.data, index),
          ),
        );
      },
    );
  }

  goToMoviesDetailPage(ItemModel data, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieBlocProvider(
        child: 
        MovieDetailScreen(
          title: data.results[index].title,
          posterUrl: data.results[index].poster_path,
          description: data.results[index].overview,
          releaseDate: data.results[index].release_date,
          voteAverage: data.results[index].vote_average.toString(),
          movieId: data.results[index].id,
        ),
      );
    }));
  }
}
