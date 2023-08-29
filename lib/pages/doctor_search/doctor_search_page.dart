import 'package:doctor_patient/bloc/doctor_search_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/pages/doctor_search/search_results_widget.dart';
import 'package:flutter/material.dart';

class DoctorSearchPage extends StatefulWidget {
  _DoctorSearchPageState createState() => _DoctorSearchPageState();
}

class _DoctorSearchPageState extends State<DoctorSearchPage> {
  final searchTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = sl<DoctorSearchBloc>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Find & Book'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
            color: Colors.deepOrange,
            child: TextField(
              controller: searchTextCtrl,
              onChanged: (s) {
                bloc.updateSearchText(s);
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                hintText: 'Search doctor',
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      searchTextCtrl.text = '';
                    });
                  },
                ),
              ),
            ),
          ),
          SearchResultsWidget(),
        ],
      ),
    );
  }
}
