import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/Helper_Widgets/moviePoster.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Main_Flow/movieFilter.dart';
import '../components/Text.dart';
import 'moviesMainPage.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                    backgroundColor: Colors.blue, shape: const StadiumBorder()),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return const MovieMainPage();
                  },));
                },
                child: const CustomText(
                  "Search",
                  size: 24,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
