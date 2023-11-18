import 'package:flutter/material.dart';
import 'package:movie_app/Screens/mainScreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Intro Screen")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // GAMES
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff9C27B0),
              ),
              child: Image.asset('assets/img.png'),
            ),
            // Movies
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return MovieScreen();
                },));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffFFDE59),
                ),
                child: Image.asset('assets/img_1.png'),
              ),
            ),
            // DONATIONS
            Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff17C1D6),
                    Color(0xffF9DD5C),
                  ],
                ),
              ),
              child: Image.asset('assets/img_2.png'),
            ),
          ],
        ),
      ),
    );
  }
}