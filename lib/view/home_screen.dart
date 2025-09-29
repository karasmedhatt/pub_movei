import 'package:best_movei/models/movie.dart';
import 'package:best_movei/view/favorit.dart';
import 'package:best_movei/viewModel/app_Prain.dart';
import 'package:best_movei/viewModel/themeprovider.dart';
import 'package:best_movei/widget/movicard.dart';
import 'package:best_movei/widget/shimmer.dart';
import 'package:best_movei/widget/textcolors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final pos = _scrollController.position.pixels;
      final max = _scrollController.position.maxScrollExtent;
      if (pos >= max - 150) {
        if (appBrain.hasMore && !appBrain.isLoading.value) {
          appBrain.fetchNextPage(); 
        }
      }
    });
    appBrain.fetchInitialMovies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text("Movies"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 7.0),
                child: Stack(
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
                          MaterialPageRoute(
                            builder: (_) => const FavoritesScreen(),
                          ),
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
                              style: TextStyle(
                                color: themeProvider.isDark
                                    ? TextColors.darkText
                                    : TextColors.lightText,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Gap(9),
              Padding(
                padding: const EdgeInsets.only(top: 7.0),
                child: IconButton(
                  icon: const Icon(Icons.nightlight),
                  onPressed: () {
                    context.read<ThemeProvider>().toggleTheme();
                  },
                ),
              ),
            ],
          ),
        ),

        body: ValueListenableBuilder<List<Movie>>(
          valueListenable: appBrain.movies,
          builder: (context, movies, _) {
            final itemCount = movies.isEmpty ? 5 : movies.length;

            return ListView.builder(
              controller: _scrollController,
              itemCount: itemCount,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                if (movies.isEmpty) {
                  return const MovieCardShimmer();
                } else {
                  return MovieCard(model: movies[index]);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
