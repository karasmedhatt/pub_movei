import 'package:best_movei/view/favorit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:best_movei/viewModel/themeprovider.dart';

class FavoritesIconWithBadge extends StatelessWidget {
  const FavoritesIconWithBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(
            Icons.favorite_rounded,
            color: Colors.redAccent,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  FavoritesScreen()),
            );
          },
        ),
      
        Consumer<FavoritesProvider>(
          builder: (context, favs, _) {
            if (favs.favorites.isEmpty) return const SizedBox();
            return Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  favs.favorites.length.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
