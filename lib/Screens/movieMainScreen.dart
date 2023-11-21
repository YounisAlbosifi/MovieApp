
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/movieResult.dart';
import '../Components/Text.dart';
import '../Helpers/movieAPI.dart';
import '../Helpers/moviePoster.dart';
import 'movieFilterScreen.dart';
import 'movieSearchResults.dart';


class MovieMainScreen extends StatefulWidget {
  const MovieMainScreen({super.key});

  @override
  State<MovieMainScreen> createState() => _MovieMainScreenState();
}

class _MovieMainScreenState extends State<MovieMainScreen>{

  List<MovieResult> nowShowingMovies = [];
  List<MovieResult> popularMovies = [];
  List<MovieResult> topRatedMovies = [];
  List<MovieResult> upComingMovies = [];
  List<MovieResult> recommended = [];
  double containerHeight = 350;
  var textColor = Colors.black;



  int page = 1;
  Future<void> _fetchData() async {
    Api api = Api(page: page);
    var nowShowingResults = await api.CallMovieNowShowing();
    var popularResults = await api.CallMoviePopular();
    var topRatedResults = await api.CallMovieTopRated();
    var upComingResults = await api.CallMovieUpComing();

    setState(() {
      nowShowingMovies.addAll(nowShowingResults.results);
      popularMovies.addAll(popularResults.results);
      topRatedMovies.addAll(topRatedResults.results);
      upComingMovies.addAll(upComingResults.results);

      // Filter out movies with backdrop path "404"
      nowShowingMovies.removeWhere((movie) => movie.backdropPath == "404");
      popularMovies.removeWhere((movie) => movie.backdropPath == "404");
      topRatedMovies.removeWhere((movie) => movie.backdropPath == "404");
      upComingMovies.removeWhere((movie) => movie.backdropPath == "404");


      // ZIG ZAG BABY
      recommended.addAll(topRatedMovies.take(1));
      recommended.addAll(popularMovies.take(3));
      recommended.addAll(topRatedMovies.take(1));
      recommended.addAll(popularMovies.take(3));
      recommended.addAll(topRatedMovies.skip(5));
    });
  }

  Future<void> _filRecommended(int id) async {
    Api api = Api(page: page);
    var recommendedResults = await api.CallMovieRecommendations(id.toString());
    setState(() {
      for(int i = 0; i < 7; i++){
        if(recommendedResults.results[i].backdropPath == "404"){
          continue;
        }
        recommended.insert(0, recommendedResults.results[i]);
        recommended.removeLast();
      }
      recommended.toSet().toList(); // Remove Duplicates
    });
}

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {


    String? searchName;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(),
                    color: Colors.white
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search Movie",
                      hintStyle: TextStyle(
                        color: Colors.purple
                      )
                    ),

                    onSubmitted: (value) async{
                      searchName = value;
                      print("Search Name: \n $searchName");
                      Api api = Api(
                          page: 1,
                          searchName: searchName
                      );

                      List<MovieResult> movies = await api.CallMovieByNameApi();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return movieSearchResults(
                            movies: movies,
                          );
                        },
                      ));
                    },
                  ),
                ),
                SizedBox(width: 5,),
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return MovieFilter(); // Your filter screen widget
                      },
                    );
                  },
                )

              ],
            ),

          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Now Showing',
                        style: GoogleFonts.averageSans(
                            color: textColor,
                            fontSize: 24,

                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      child: nowShowingMovies.length == 0 ? Text("Not found")
                          : ListView.separated(
                        itemCount: nowShowingMovies.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            width: 16.0,
                          );
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              _filRecommended(nowShowingMovies[index].id);
                              // MOVIE DETAILS
                            },
                            child: MoviePoster(
                              title: nowShowingMovies[index].title,
                              rating: nowShowingMovies[index].voteAverage,
                              image: "https://image.tmdb.org/t/p/w500${nowShowingMovies[index].backdropPath}",
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Top Rated',
                        style: GoogleFonts.averageSans(
                            color: textColor,
                            fontSize: 24
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      child: topRatedMovies.length == 0 ? Text("Not found")
                          : ListView.separated(
                        itemCount: topRatedMovies.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            width: 16.0, // Adjust the width as needed
                          );
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              // MOVIE DETAILS
                            },
                            child: MoviePoster(
                              title: topRatedMovies[index].title,
                              rating: topRatedMovies[index].voteAverage,
                              image: "https://image.tmdb.org/t/p/w500${topRatedMovies[index].backdropPath}",
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Popular',
                        style: GoogleFonts.averageSans(
                            color: textColor,
                            fontSize: 24
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      child: popularMovies.length == 0 ? Text("Not found")
                          : ListView.separated(
                        itemCount: popularMovies.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            width: 16.0, // Adjust the width as needed
                          );
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              // MOVIE DETAILS
                            },
                            child: MoviePoster(
                              title: popularMovies[index].title,
                              rating: popularMovies[index].voteAverage,
                              image: "https://image.tmdb.org/t/p/w500${popularMovies[index].backdropPath}",
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Up Coming',
                        style: GoogleFonts.averageSans(
                            color: textColor,
                            fontSize: 24
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      child: upComingMovies.length == 0 ? Text("Not found")
                          : ListView.separated(
                        itemCount: upComingMovies.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            width: 16.0, // Adjust the width as needed
                          );
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              // MOVIE DETAILS
                            },
                            child: MoviePoster(
                              title: upComingMovies[index].title,
                              rating: upComingMovies[index].voteAverage,
                              image: "https://image.tmdb.org/t/p/w500${upComingMovies[index].backdropPath}",
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Recommended',
                        style: GoogleFonts.averageSans(
                            color: textColor,
                            fontSize: 24
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: containerHeight,
                      child: recommended.length == 0 ? Text("Not found")
                          : ListView.separated(
                        itemCount: recommended.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            width: 16.0, // Adjust the width as needed
                          );
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              // MOVIE DETAILS
                            },
                            child: MoviePoster(
                              title: recommended[index].title,
                              rating: recommended[index].voteAverage,
                              image: "https://image.tmdb.org/t/p/w500${recommended[index].backdropPath}",
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}


