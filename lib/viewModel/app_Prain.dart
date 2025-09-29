
import 'package:flutter/foundation.dart';
import 'package:best_movei/models/movie.dart';
import 'package:best_movei/services/api_services.dart';

final appBrain = AppBrain();

class AppBrain {
  final ValueNotifier<List<Movie>> movies = ValueNotifier<List<Movie>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isError = ValueNotifier<bool>(false);
  String errorMessage = '';

  int currentPage = 0;
  int totalPages = 1;

  bool get hasMore => currentPage < totalPages;
  Future<void> fetchInitialMovies() async {
    currentPage = 0;
    totalPages = 1;
    movies.value = [];
    await fetchNextPage();
  }
  Future<void> fetchNextPage() async {
    if (isLoading.value || !hasMore) return;

    isLoading.value = true;
    isError.value = false;

    try {
      final nextPage = currentPage + 1;
      final res = await ApiServices.fetchMovies(page: nextPage);
      final fetched = res['movies'] as List<Movie>;
      totalPages = res['totalPages'] as int;
      currentPage = nextPage;

      movies.value = [...movies.value, ...fetched];
    } catch (e) {
      isError.value = true;
      errorMessage = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
