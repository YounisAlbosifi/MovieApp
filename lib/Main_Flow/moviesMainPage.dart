import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Helper_Widgets/movieCard.dart';
import 'package:http/http.dart';
import 'package:movie_app/Main_Flow/movieFilter.dart';
import 'package:movie_app/constants.dart';
import '../Helper_Widgets/movieAPI.dart';
import '../classes/movieObject.dart';

class MovieMainPage extends StatefulWidget {
  const MovieMainPage({Key? key, this.appliedFilters}) : super(key: key);

  final Map<String, dynamic>? appliedFilters;

  @override
  _MovieMainPageState createState() => _MovieMainPageState();
}

class _MovieMainPageState extends State<MovieMainPage> {
  int page = 1;
  List<MovieResult> movieResults = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var api;
    Map<String, dynamic>? appliedFilters = widget.appliedFilters;
    if (appliedFilters == null){
      api = Api(page: page);
    }
    else {
      api = Api(
        year: appliedFilters['year'],
        withGenres: appliedFilters['withGenres'],
        voteAverage: appliedFilters["voteAverage"],
        runtimeChoice: appliedFilters['runtimeChoice'],
        language: appliedFilters['language'],
        page: page,
      );
    }
    var url = api.CallMovieFilterApi();
    var json = await getJson(url: url); // in constants
    print("API Response: $json");
    Movie movie = Movie.fromJson(json);
    setState(() {
      movieResults.addAll(movie.results);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies"),
        actions: [
          ElevatedButton(onPressed: () {
            page = 1;
            movieResults.clear();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const MovieFilter();
              },
            ));
          }, child: Text("Apply Filters"))
        ],
      ),
      body:  movieResults.length == 0 ?
          const Center(
            child: Column(
              children: [
                SizedBox(height: 32,),
                CircularProgressIndicator(),
                SizedBox(height: 8,),
                Text("Loading..")
              ],
            ),
          )
            : Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.black],
            end: Alignment.bottomCenter,
            begin: Alignment.topLeft,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: movieResults.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: MovieCard(
                      title: movieResults[index].title,
                      overview: movieResults[index].overview,
                      releaseDate: movieResults[index].releaseDate,
                      language: movieResults[index].originalLanguage,
                      voteAverage: movieResults[index].voteAverage,
                      voteCount: movieResults[index].voteCount,
                      genre_ids: movieResults[index].genreIds,
                      posterPath:
                      movieResults[index].backdrop_path == "https://ih1.redbubble.net/image.980012480.5663/st,small,507x507-pad,600x600,f8f8f8.u3.jpg" ?
                      "https://ih1.redbubble.net/image.980012480.5663/st,small,507x507-pad,600x600,f8f8f8.u3.jpg" :
                      "https://image.tmdb.org/t/p/w500${movieResults[index].backdrop_path}",
                    ),
                    onTap: (){
                      // GO TO MOVIE DETAILS
                      // using movieResults[index].id
                      /*Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return WIDGET();
                        },
                      ));
                       */
                    },
                  );
                },
              ),
              ElevatedButton(onPressed: (){setState(() {
                page++;
                _fetchData();
              });}, child: Text("Load More movies"))
            ],
          ),
        ),
      ),
    );
  }
}
