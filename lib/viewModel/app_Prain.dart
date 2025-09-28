import 'package:best_movei/models/movie.dart';
import 'package:flutter/foundation.dart';


final appBrain = AppBrain();

class AppBrain {

  final ValueNotifier<List<Movie>> movies = ValueNotifier<List<Movie>>([]);
}
