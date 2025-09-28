

class Movie {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    double _toDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is int) return v.toDouble();
      if (v is double) return v;
      return double.tryParse(v.toString()) ?? 0.0;
    }

    return Movie(
      adult: map['adult'] ?? false,
      backdropPath: map['backdrop_path'],
      genreIds: List<int>.from(map['genre_ids'] ?? []),
      id: map['id'] ?? 0,
      originalLanguage: map['original_language'] ?? '',
      originalTitle: map['original_title'] ?? '',
      overview: map['overview'] ?? '',
      popularity: _toDouble(map['popularity']),
      posterPath: map['poster_path'],
      releaseDate: map['release_date'] as String? ?? '',
      title: map['title'] ?? '',
      voteAverage: _toDouble(map['vote_average']),
      voteCount: map['vote_count'] ?? 0,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) => Movie.fromMap(json);
  
  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Movie && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
