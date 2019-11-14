class TrailerMovieModel {
  List<_Result> _result = [];

  TrailerMovieModel.fromJson(Map<String, dynamic> parseJson) {
    List<_Result> temp = [];
    for (int i = 0; i < parseJson['results'].length; i++) {
      _Result result = _Result(parseJson['results'][i]);
      temp.add(result);
    }
    _result = temp;
  }

  List<_Result> get results => _result;
}

class _Result {
  String key;
  String name;

  _Result(result) {
    key = result['key'];
    name = result['name'];
  }

  String get keyMovie => key;

  String get nameMovie => name;
}
