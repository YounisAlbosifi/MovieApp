import 'package:flutter/material.dart';

import '../Classes/movieResult.dart';
import '../Helpers/movieCard.dart';

class movieSearchResults extends StatelessWidget {
  movieSearchResults({required this.movies, super.key});
  static String id = "SearchResults";
  List<MovieResult> movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Search Results"),
      ),

      body:
      movies.length == 0 ? Column(children: [Text("Not found")],) :
      ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index){
            return MovieCard(
              title: movies[index].title,
              overview: movies[index].overview,
              releaseDate: movies[index].releaseDate,
              language: movies[index].originalLanguage,
              voteAverage: movies[index].voteAverage,
              voteCount: movies[index].voteCount,
              genreIds: movies[index].genreIds,
              posterPath:
              movies[index].backdropPath == "404" ?
              "https://ih1.redbubble.net/image.980012480.5663/st,small,507x507-pad,600x600,f8f8f8.u3.jpg" :
              "https://image.tmdb.org/t/p/w500${movies[index].backdropPath}",
            );
          }
      ),
    );
  }
}
