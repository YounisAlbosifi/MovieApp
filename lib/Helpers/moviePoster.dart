import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({Key? key, required this.title, required this.image, required this.rating})
      : super(key: key);

  final String title;
  final String image;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            image,
            width: 150,
            height: 250,
            fit: BoxFit.fitHeight,
          ),
        ),
        SizedBox(height: 15,),
        Container(
          width: 150, // Adjust the width as needed
          child: Text(
            title,
            maxLines: 2, // Adjust the max number of lines
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.aBeeZee(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5,),
        Container(
          width: 150, // Adjust the width as needed
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("⭐"),
                  SizedBox(width: 5),
                  Text(
                    "${rating.toStringAsFixed(1)}/10 IMDB",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
