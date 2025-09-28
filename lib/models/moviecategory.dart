import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<int, String>> fetchGenres(String apiKey) async {
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
