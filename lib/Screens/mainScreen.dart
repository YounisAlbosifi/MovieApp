import 'package:flutter/material.dart';
import 'package:movie_app/Helpers/moviePoster.dart';
import 'package:movie_app/Screens/movieMainScreen.dart';
import 'package:movie_app/Screens/movieFilterScreen.dart';
import '../Classes/movieResult.dart';
import '../Helpers/movieAPI.dart';
import '../Components//Text.dart';
import 'movieSearchResults.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});
  static String id = "Main";

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  int _currentIndex = 0;

  // Define your pages or content for each tab
  final List<Widget> _pages = [
    MovieMainScreen(),
    Text("Not implemented"),
    Text("Not implemented"),
  ];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Main Screen"),
          SizedBox(width: 8), // Adjust the spacing as needed
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget)); // REFRESH PAGE
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_filter_outlined),
            label: "Movies",
            backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection_outlined),
              label: "Shows",
              backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.gamepad_outlined),
              label: "Games",
              backgroundColor: Colors.blueAccent
          ),
        ],
      ),
    );
  }
}
