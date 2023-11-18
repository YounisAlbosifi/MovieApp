import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// IMAGE TESTING!!
class MoviePoster extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        child: Container(
            width: 140,
            child: Image.asset('assets/img_1.png',fit: BoxFit.contain,)),
      ),
    );
  }
}
