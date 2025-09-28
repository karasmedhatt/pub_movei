import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:best_movei/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider extends ChangeNotifier {
  bool _isDark = true; 

  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners(); 
  }
}



class FavoritesProvider extends ChangeNotifier {
  final List<Movie> _favorites = [];
  List<Movie> get favorites => List.unmodifiable(_favorites);

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('favorites') ?? [];
    _favorites.addAll(stored.map((e) => Movie.fromJson(jsonDecode(e))));
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _favorites.map((m) => jsonEncode(m.toJson())).toList();
    await prefs.setStringList('favorites', data);
  }

  void toggleFavorite(Movie movie) {
    final exists = _favorites.any((m) => m.id == movie.id);
    if (exists) {
      _favorites.removeWhere((m) => m.id == movie.id);
    } else {
      _favorites.add(movie);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Movie movie) =>
      _favorites.any((m) => m.id == movie.id);
}

