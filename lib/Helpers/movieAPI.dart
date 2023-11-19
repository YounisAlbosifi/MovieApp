import 'package:movie_app/Classes/movieResult.dart';

import '../Classes/movieResult.dart';
import '../constants.dart';

class Api {
  Api({
    this.year,
    this.withGenres,
    this.voteAverage,
    this.runtimeChoice,
    this.language,
    this.searchName,
    required this.page
  });


  String? language; // DONE
  int? year; // On hold
  List<String>? withGenres; // DONE
  double? voteAverage; // DONE
  String? runtimeChoice;
  String? searchName;// On hold
  int page;

  Future<List<MovieResult>> CallMovieFilterApi() async{
    List<MovieResult>? movies;/// THIS WILL RETURN A URL
    var string = StringBuffer();
    string.write(
        "https://api.themoviedb.org/3/discover/movie?api_key=81a08eb3db0b620adcaf8a8fecc5c880&include_adult=false&include_video=false&language=en-US&page=${page}&sort_by=popularity.desc"
    );
    if(language != null){
      string.write("&with_original_language=$language");
    }
    if (withGenres != null) {
      string.write("&with_genres=");
      for (int i = 0; i < withGenres!.length; i++) {
        string.write(genreIdMap[withGenres![i]]);
        print("Genre: ${withGenres![i]}");
        if (i != withGenres!.length - 1) string.write(",");
        print(string.toString());
      }
    }
    if(year != null){
      string.write("&primary_release_year=${year}");
    }
    if(voteAverage != null){
      string.write("&vote_average.gte=${voteAverage}");
    }
    if(runtimeChoice != null) {
      if (runtimeChoice == "short") {
        string.write(
            "&with_runtime.lte=60"); // only movies that have less than 60 minutes
      }
      else if (runtimeChoice == "normal") {
        string.write(
            "&with_runtime.lte=200"); // only movies that have less than 200 minutes
      }
      else if (runtimeChoice == "long") {
        string.write(
            "&with_runtime.gte=200"); // only movies that have 200+ minutes
      }
    }
    String finalUrl = string.toString();
    print("final url is: $finalUrl");

    var json = await getJson(url: finalUrl);
    Movie movie = Movie.fromJson(json);
    movies = movie.results;
    return movies;
  }
  Future<List<MovieResult>> CallMovieByNameApi() async{
    List<MovieResult>? movies;
    String finalUrl = "https://api.themoviedb.org/3/search/movie?api_key=81a08eb3db0b620adcaf8a8fecc5c880&query=$searchName&include_adult=false&language=en-US&page=$page";

    var json = await getJson(url: finalUrl);
    Movie movie = Movie.fromJson(json);
    movies = movie.results;
    return movies;
  }
}