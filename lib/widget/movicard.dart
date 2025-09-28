import 'package:best_movei/constants/details.dart';
import 'package:best_movei/models/movie.dart';
import 'package:best_movei/view/detailscreen.dart';
import 'package:best_movei/viewModel/themeprovider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';

class MovieCard extends StatelessWidget {
  final Movie model;
  final VoidCallback? onFavoriteTap;

  const MovieCard({super.key, required this.model, this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (model.posterPath == null || model.posterPath!.isEmpty)
              ? const Icon(Icons.broken_image, size: 100)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailsScreen(movie: model),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${model.posterPath}',
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 100,
                          height: 150,
                          color: Colors.grey,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                ),
          const Gap(9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(9),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber),
                    const Gap(5),
                    Text(
                      '${model.voteAverage.toStringAsFixed(1)}/10',
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                  ],
                ),
                const Gap(9),
                Wrap(
                  spacing: 9,
                  runSpacing: 4,
                  children: model.genreIds.map((id) {
                    final name = GenreHelper.genreMap[id] ?? 'Unknown';
                    return Text(
                      name,
                      style: const TextStyle(
                        color: Color.fromARGB(221, 188, 188, 188),
                      ),
                    );
                  }).toList(),
                ),
                const Gap(9),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.green),
                    const Gap(4),
                    Text(
                      model.releaseDate ?? '',
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                    const Spacer(),
                    Consumer<FavoritesProvider>(
                      builder: (context, favs, _) => IconButton(
                        icon: Icon(
                          favs.isFavorite(model)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favs.isFavorite(model)
                              ? Colors.red
                              : const Color.fromARGB(255, 97, 97, 97),
                        ),
                        onPressed: () => favs.toggleFavorite(model),
                      ),
                    ),
                    if (model.adult) ...[
                      const Gap(6),
                      const Text(
                        'Adult',
                        style: TextStyle(color: Colors.redAccent, fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
