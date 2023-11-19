import 'package:flutter/material.dart';
import 'package:movie_app/Classes/movieResult.dart';
import 'package:movie_app/Helpers/movieCard.dart';

class MovieFilterResults extends StatelessWidget {
  const MovieFilterResults({required this.appliedFilters, this.movies, Key? key}) : super(key: key);
  final Map<String, dynamic>? appliedFilters;
  final List<MovieResult>? movies;
  static String id = "FilterResults";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Filter Results")
      ),

      body: Container(
        height: double.infinity,
        width: double.infinity,

        child: movies == null ?
        const Center(
          child: Column(
            children: [
              SizedBox(height: 32,),
              CircularProgressIndicator(),
              SizedBox(height: 8,),
              Text("Loading...")
            ],
          ),
        ) : ListView.builder(
            itemBuilder: (context, index){
              return MovieCard(
              title: movies![index].title,
              overview: movies![index].overview,
              releaseDate: movies![index].releaseDate,
              language: movies![index].originalLanguage,
              voteAverage: movies![index].voteAverage,
              voteCount: movies![index].voteCount,
              genreIds: movies![index].genreIds,
              posterPath:
              movies![index].backdropPath == "https://ih1.redbubble.net/image.980012480.5663/st,small,507x507-pad,600x600,f8f8f8.u3.jpg" ?
              "https://ih1.redbubble.net/image.980012480.5663/st,small,507x507-pad,600x600,f8f8f8.u3.jpg" :
              "https://image.tmdb.org/t/p/w500${movies![index].backdropPath}",
              );
            }
        ),
      ),
    );
  }
}
