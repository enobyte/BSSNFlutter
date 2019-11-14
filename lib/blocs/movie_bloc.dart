import 'package:flutter_apps/models/m_list_movie.dart';
import 'package:flutter_apps/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final _repository = Repository();
  final _moveFetch = PublishSubject<MListMovieModel>();

  Observable<MListMovieModel> get allMovie => _moveFetch.stream;

  fetchAllMovie() async {
    MListMovieModel model = await _repository.fetchDataMovie();
    _moveFetch.sink.add(model);
  }

  dispose() {
    _moveFetch.close();
  }
}
