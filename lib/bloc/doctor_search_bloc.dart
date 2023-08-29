import 'package:doctor_patient/models/doctor_search_result.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class DoctorSearchBloc {
  final _searchResultsSubject = BehaviorSubject<List<DoctorSearchResult>>();

  String _searchText = '';
  String _category = '';

  Stream<List<DoctorSearchResult>> get searchResults =>
      _searchResultsSubject.stream;

  void updateCategory(data) {
    _category = data;
    searchDoctor();
  }

  void updateSearchText(data) {
    _searchText = data;
    searchDoctor();
  }

  Future<void> searchDoctor() async {
    try {
      dynamic results = await Repository.searchDoctor(
        queryString: _searchText,
        category: _category,
      );

      _searchResultsSubject.add(results);
    } catch (e) {
      _searchResultsSubject.addError(e);
    }
  }

  void dispose() {
    _searchResultsSubject.close();
  }
}
