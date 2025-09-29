

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:best_movei/models/movie.dart';
import 'package:best_movei/viewModel/app_Prain.dart';

class ApiServices {
  static const String _apiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDVmZWQ2MWU1MzgzOWU2MDY2ZDZlMjY2MWYzNmY0ZSIsIm5iZiI6MTcyODkzNzQwMi4xNTkwMDAyLCJzdWIiOiI2NzBkN2RiYTlmMzUzMWU2YjI2YzFhODUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.C6_Tu-WhsulYBvjx7lMzBE74AbNSoerdKLOXeHQAYxU";
  static Future<Map<String, dynamic>> fetchMovies({int page = 1}) async {
    final endpoint =
        "https://api.themoviedb.org/3/movie/popular?page=$page&language=en-US";
    final headers = {"Authorization": "Bearer $_apiKey"};
    final url = Uri.parse(endpoint);

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      final results = decoded["results"] as List<dynamic>;
      final movies = results
          .map((e) => Movie.fromMap(e as Map<String, dynamic>))
          .toList();

      final totalPages = decoded['total_pages'] as int? ?? 1;

      return {
        'movies': movies,
        'totalPages': totalPages,
      };
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }

  static Future<Map<int, String>> fetchGenres() async {
    final url =
        Uri.parse('https://api.themoviedb.org/3/genre/movie/list?language=en-US');
    final response =
        await http.get(url, headers: {"Authorization": "Bearer $_apiKey"});

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final genres = data['genres'] as List;
      return {
        for (var g in genres)
          g['id'] as int: g['name'] as String,
      };
    } else {
      throw Exception('Failed to fetch genres');
    }
  }
}


