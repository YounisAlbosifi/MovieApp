import 'package:flutter/material.dart';
import 'package:movie_app/Helpers/moviePoster.dart';
import 'package:movie_app/Screens/movieFilterScreen.dart';
import '../Classes/movieResult.dart';
import '../Helpers/movieAPI.dart';
import '../components/Text.dart';
import 'movieSearchResults.dart';

class MovieScreen extends StatefulWidget {
  MovieScreen({super.key});
  static String id = "Main";

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  String? searchName;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsets.only(left: 100),
        child: Text("hfygui"),
      ),

      leading: const Icon(Icons.menu),
    ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 350,

                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search Movie",
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
                const Padding(
                  padding: EdgeInsets.only(left:8.0),
                  child: Icon(Icons.menu),
                )
              ],
            ),

          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: const CustomText(
                        'Recommended 🤌🏻',
                        color: Colors.cyan,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[100],
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return MoviePoster();
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: CustomText(
                        "Trending 🔥",
                        color: Colors.purple[300],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[100],
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return MoviePoster();
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: const CustomText(
                        "Top Rated 🤩",
                        color: Colors.red,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[100],
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return MoviePoster();
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  // SEARCH BUTTON
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: const StadiumBorder()
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, MovieFilter.id);
                      },
                      child: const CustomText(
                        "Search Filter",
                        size: 24,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
