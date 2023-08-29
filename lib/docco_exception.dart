class DoccoException implements Exception {
  Map<String, dynamic>? _cause;
  String? _message;
  int? _code;

  DoccoException(this._cause, this._code) {
    var map;
    try {
      map = _cause;
      print('Came here in DOCCO EXCEPTION');
      print('ERROR CODE $_code');
      print('MESSAGE $_cause');
      if (this._code == 401) {
        _message = map['error'];
        print(_message);
      } else if (this._code == 422) {
        _message = map['error']['message'];
      } else if (this._code == 404) {
        _message = map['message'];
      }
    } catch (e) {
      print('UNKNOWN ERROR FROM SERVER');
      _message = this._cause.toString();
    }
  }

  String? getMessage() {
    return _message;
  }

  int? getCode() {
    return _code;
  }
}
