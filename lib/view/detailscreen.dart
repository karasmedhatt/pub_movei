import 'package:best_movei/constants/details.dart';
import 'package:best_movei/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  width: 220,
                  height: 330,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image, size: 120),
                ),
              ),
            ),
            const Gap(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.2),
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(8),
            Text(
              'Release Date: ${movie.releaseDate ?? 'Unknown'}',
              style: const TextStyle(
                  color: Color.fromARGB(221, 200, 200, 200), fontSize: 14),
            ),
            const Gap(12),

            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: movie.genreIds.map((id) {
                final name = GenreHelper.genreMap[id] ?? 'Unknown';
                return Chip(
                  label: Text(name),
                  backgroundColor: Colors.grey.shade800,
                  labelStyle: const TextStyle(color: Colors.white),
                );
              }).toList(),
            ),
            const Gap(16),
            const Text(
              'Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Gap(8),
            Text(
              movie.overview.isNotEmpty
                  ? movie.overview
                  : 'No overview available.',
              style: const TextStyle(
                  color: Color.fromARGB(221, 220, 220, 220), fontSize: 15),
            ),
              const Gap(8),
          ],
        ),
      ),
    );
  }
}
