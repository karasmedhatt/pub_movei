import 'package:best_movei/viewModel/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:best_movei/models/movie.dart';
import 'package:best_movei/widget/movicard.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites')),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final Movie movie = favorites[index];
                return MovieCard(model: movie);
              },
            ),
    );
  }
}
