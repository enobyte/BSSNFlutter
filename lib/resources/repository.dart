import 'package:flutter_apps/models/m_list_movie.dart';
import 'package:flutter_apps/resources/movie_api_provider.dart';

class Repository {
  final movieProvider = MovieApiProvider();

  Future<MListMovieModel> fetchDataMovie() => movieProvider.fetchMovieList();
}
