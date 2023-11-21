class Movie {
  final int page;
  final List<MovieResult> results;


  Movie({required this.page, required this.results});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      page: json['page'],
      results: (json['results'] as List).map((resultJson) => MovieResult.fromJson(resultJson)).toList(),
    );
  }
}

class MovieResult {
  final bool adult;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final String? backdropPath;

  MovieResult({
    required this.adult,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.backdropPath
  });

  factory MovieResult.fromJson(Map<String, dynamic> json) {
    return MovieResult(
      adult: json['adult'],
      genreIds: List<int>.from(json['genre_ids']),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble() ?? 0,
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble() ?? 0,
      voteCount: json['vote_count'] ?? 0,
      backdropPath: json['backdrop_path'] ?? '404',
    );
  }
}
