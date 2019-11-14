import 'package:flutter_apps/models/m_trailer_movie.dart';
import 'package:flutter_apps/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieTrailerBloc {
  final _repository = Repository();
  final _trailer = PublishSubject<Future<TrailerMovieModel>>();
  final _movieId = PublishSubject<int>();

  Function(int) get fetchTrailerById => _movieId.sink.add;

  Observable<Future<TrailerMovieModel>> get movieTrailers => _trailer.stream;

  MovieTrailerBloc() {
    _movieId.stream.transform(_itemTransform()).pipe(_trailer);
  }

  dispose() async {
    _movieId.close();
    await _trailer.drain();
    _trailer.close();
  }

  _itemTransform() {
    return ScanStreamTransformer(
        (Future<TrailerMovieModel> trailer, int id, int index) {
      trailer = _repository.fetchDataTrailer(id.toString());
      return trailer;
    });
  }
}
