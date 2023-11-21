import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String overview;
  final String releaseDate;
  final String language;
  final double voteAverage;
  final int voteCount;
  final String posterPath;
  final List genreIds;

  const MovieCard({super.key,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.language,
    required this.voteAverage,
    required this.voteCount,
    required this.posterPath,
    required this.genreIds,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          Image.network(
            posterPath,
            width: double.infinity,
            height: 200, // Adjust the height as needed
            fit: BoxFit.cover, // Maintain aspect ratio and cover the container
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Release Date: $releaseDate',
                  style: const TextStyle(fontSize: 21),
                ),
                const SizedBox(height: 8),
                Text(
                  "Language: ${countryIcons[language]}",
                  style: const TextStyle(fontSize: 21),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('Ratings: $voteAverage', style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 2,),
                    const Icon(Icons.star, size: 21,),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Number of votes: $voteCount',
                  style: const TextStyle(fontSize: 21),
                ),
                Text(
                  'Genres: ${genreIds == 0 ? "Unknown" : genreIds
                      .map((id) => IdGenreMap[id])
                      .where((genre) => genre != null)
                      .toList().join(", ")}',
                  style: const TextStyle(fontSize: 21),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Overview:',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  overview.length <= 350 ? overview : overview.substring(0,280) +"...", // Truncate string if it's too long
                  style: GoogleFonts.ubuntu(
                      fontSize: 20
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  'Click For More Details',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
