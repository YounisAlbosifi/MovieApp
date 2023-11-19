import 'package:flutter/material.dart';
import 'package:movie_app/Screens/mainScreen.dart';
import 'package:movie_app/Screens/movieFilterResults.dart';
import 'package:movie_app/Screens/movieFilterScreen.dart';
import 'Screens/introScreen.dart';

void main() {
  runApp(const MyApp());
}

final Map<String, WidgetBuilder> routes = {
  IntroScreen.id: (context) => const IntroScreen(),
  MovieScreen.id: (context) => MovieScreen(),
  MovieFilter.id: (context) => const MovieFilter(),
  // Add more routes as needed...
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: routes,
      initialRoute: IntroScreen.id,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IntroScreen(),
    );
  }
}
