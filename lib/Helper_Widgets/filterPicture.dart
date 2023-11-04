import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/Text.dart';
import 'package:movie_app/Main_Flow/movieFilter.dart';
class FilterPicture extends StatelessWidget {
  FilterPicture({super.key,
    required this.imagePath,
    this.genreName,
    required this.onTap,
    this.isSelected,
    // Optional: Initialize isSelected flag
  });

  final String imagePath;
  final String? genreName;
  final VoidCallback onTap;
  bool? isSelected;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(

          border: Border.all(
              color: isSelected! ? Colors.green : Colors.transparent,
              width: 5.0
          ),
        ),
        child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      );
  }
}
