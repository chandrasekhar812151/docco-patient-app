import 'package:doctor_patient/bloc/doctor_search_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/models/doctor_search_result.dart';
import 'package:doctor_patient/pages/doctor_search/search_list_item.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:doctor_patient/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';

class SearchResultsWidget extends StatefulWidget {
  _SearchResultsWidgetState createState() => _SearchResultsWidgetState();
}

class _SearchResultsWidgetState extends State<SearchResultsWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bloc = sl<DoctorSearchBloc>();
    return StreamBuilder<List<DoctorSearchResult>>(
      stream: bloc.searchResults,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Container(
            padding: EdgeInsets.only(top: 16),
            child: CustomErrorWidget(snapshot.error.toString(),onRetry: () {
              setState(() {});
            }),
          );
        }

        if (snapshot.hasData && snapshot.data!.length > 0) {
          List<DoctorSearchResult>? list = snapshot.data;
          return Expanded(
            child: ListView.builder(
              itemCount: list?.length,
              itemBuilder: (context, index) {
                return SearchListItem(list![index]);
              },
            ),
          );
        } else {
          return Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FractionallySizedBox(
                      widthFactor: 0.7,
                      child: Image.asset(UIData.emptyImage),
                    ),
                    SizedBox(height: 16),
                    Text('NO RESULTS FOUND',
                        style: textTheme.titleLarge?.copyWith(color: Colors.black54)),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
