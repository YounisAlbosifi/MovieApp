import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final Map<String, int> genreIdMap = {
  "Action": 28,
  "Animation": 16,
  "Comedy": 35,
  "Drama": 18,
  "Fantasy": 14,
  "Horror": 27,
  "War": 10752,
  "Romance": 10749,
  "Science Fiction" : 878,
  // Add more genres as needed
};
final Map<int, String> IdGenreMap = {
  28: "Action",
  16: "Animation",
  35: "Comedy",
  18: "Drama",
  14: "Fantasy",
  27: "Horror",
  10752: "War",
  10749: "Romance",
  878: "Science_Fiction",
  // Add more genres as needed
};

List<String> genres = [
  'Action',
  'Drama',
  'Fantasy',
  'Comedy',
  'Animation',
  'Horror',
  'War',
  'Romance',
  'Science_Fiction'
];
Future<dynamic> getJson({required String url}) async {
  http.Response res = await http.get(Uri.parse(url));

  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  else {
    throw Exception('Problem with status code: ${res.statusCode}');
  }
}