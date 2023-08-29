import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/bloc/slots_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Model {

  _Model();

  getDateOfMonth(String dateString) {
    DateTime date = DateFormat('y-M-d').parse(dateString);
    return date.day.toString();
  }

  getDay(String dateString) {
    return DateFormat('EEE').format(DateTime.parse(dateString));
  }

  getMonth(String dateString) {
    DateTime date = DateFormat('y-M-d').parse(dateString);
    return DateFormat('yMMM').format(date).toUpperCase();
  }

  getYear(String dateString) {
    DateTime date = DateFormat('y-M-d').parse(dateString);
    return DateFormat('').format(date).toUpperCase();
  }
}

class DatesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = sl<SlotsBloc>();
    return StreamBuilder<Map<String, dynamic>>(
      stream: bloc.formattedSlotsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }

        final model = snapshot.data;
        final m = _Model();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('SELECT DATE', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54)),
            SizedBox(height: 8),
            Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  String? key = snapshot.data?.keys.toList()[index];
                  return GestureDetector(
                    onTap: () {
                      print('Tapped on $index');
                      model
                          ?.forEach((date, element) => model[date]['isSelected'] = false);
                      model?[key]['isSelected'] = true;
                      bloc.selectDay(key);
                    },
                    child: Container(
                      width: 90,
                      child: Card(
                        elevation: model?[key]['isSelected'] ? 2 : 0,
                        color: model?[key]['isSelected']
                            ? Colors.orange
                            : Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(m.getDateOfMonth(key!),
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: model?[key]['isSelected'] ? Colors.white : Colors.black
                            )),
                            Text(m.getDay(key),
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: model?[key]['isSelected'] ? Colors.white : Colors.black
                            )),
                            Text(m.getMonth(key),
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: model?[key]['isSelected'] ? Colors.white : Colors.black
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
