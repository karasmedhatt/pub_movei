// // import 'dart:convert';
// // import 'package:best_movei/models/movie.dart';
// // import 'package:best_movei/viewModel/app_Prain.dart';
// // import 'package:http/http.dart' as http;

// // class ApiServices {
  

// //   ApiServices() {
  
// //   }

// //   static Future<List<Movie>> fetchMovies() async {
// //       final String endpoint = "https://api.themoviedb.org/3/movie/popular";
// //   final String apiKey =
// //       "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDVmZWQ2MWU1MzgzOWU2MDY2ZDZlMjY2MWYzNmY0ZSIsIm5iZiI6MTcyODkzNzQwMi4xNTkwMDAyLCJzdWIiOiI2NzBkN2RiYTlmMzUzMWU2YjI2YzFhODUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.C6_Tu-WhsulYBvjx7lMzBE74AbNSoerdKLOXeHQAYxU";

// //   final Map<String, String> headers= {"Authorization": "Bearer $apiKey"};
// //   final Uri url = Uri.parse(endpoint);;

// //     final response = await http.get(url, headers: headers);

// //     if (response.statusCode == 200) {
// //       final decoded = json.decode(response.body) as Map<String, dynamic>;
// //       final results = decoded["results"] as List<dynamic>;

// //       final movies = results
// //           .map((e) => Movie.fromMap(e as Map<String, dynamic>))
// //           .toList();

// //       print(movies);

// //       appBrain.movies.value = movies;

// //       return movies;
// //     } else {
// //       throw Exception('Failed to load movies: ${response.statusCode}');
// //     }
// //   }
// // }



// import 'dart:convert';
// import 'package:best_movei/models/movie.dart';
// import 'package:best_movei/viewModel/app_Prain.dart';
// import 'package:http/http.dart' as http;

// class ApiServices {
//   static const String _endpoint = "https://api.themoviedb.org/3/movie/popular";
//   static const String _apiKey =
//       "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDVmZWQ2MWU1MzgzOWU2MDY2ZDZlMjY2MWYzNmY0ZSIsIm5iZiI6MTcyODkzNzQwMi4xNTkwMDAyLCJzdWIiOiI2NzBkN2RiYTlmMzUzMWU2YjI2YzFhODUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.C6_Tu-WhsulYBvjx7lMzBE74AbNSoerdKLOXeHQAYxU"; 

//   static Future<List<Movie>> fetchMovies() async {
//     final headers = {"Authorization": "Bearer $_apiKey"};
//     final url = Uri.parse(_endpoint);

//     final response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       final decoded = json.decode(response.body) as Map<String, dynamic>;
//       final results = decoded["results"] as List<dynamic>;

//       final movies = results
//           .map((e) => Movie.fromMap(e as Map<String, dynamic>))
//           .toList();

      
//       appBrain.movies.value = movies;

//       return movies;
//     } else {
//       throw Exception('Failed to load movies: ${response.statusCode}');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:best_movei/models/movie.dart';
import 'package:best_movei/viewModel/app_Prain.dart';

class ApiServices {
  static const String apiKey =  "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDVmZWQ2MWU1MzgzOWU2MDY2ZDZlMjY2MWYzNmY0ZSIsIm5iZiI6MTcyODkzNzQwMi4xNTkwMDAyLCJzdWIiOiI2NzBkN2RiYTlmMzUzMWU2YjI2YzFhODUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.C6_Tu-WhsulYBvjx7lMzBE74AbNSoerdKLOXeHQAYxU";
  
  static Future<List<Movie>> fetchMovies() async {
    final String endpoint = "https://api.themoviedb.org/3/movie/popular";
    final headers = {"Authorization": "Bearer $apiKey"};
    final url = Uri.parse(endpoint);

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      final results = decoded["results"] as List<dynamic>;
      final movies = results
          .map((e) => Movie.fromMap(e as Map<String, dynamic>))
          .toList();

      appBrain.movies.value = movies;
      return movies;
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }

  static Future<Map<int, String>> fetchGenres() async {
    final url = Uri.parse('https://api.themoviedb.org/3/genre/movie/list');
    final response = await http.get(url, headers: {"Authorization": "Bearer $apiKey"});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final genres = data['genres'] as List;
      return {for (var g in genres) g['id'] as int : g['name'] as String};
    } else {
      throw Exception('Failed to fetch genres');
    }
  }
}

