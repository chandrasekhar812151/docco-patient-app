import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/bloc/slots_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SlotChipsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = sl<SlotsBloc>();
    return StreamBuilder<List<dynamic>>(
        stream: bloc.selectedDaySlotsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          final model = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('SELECT SLOT',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black54)),
              SizedBox(height: 8),
              Wrap(
                children: List<Widget>.generate(model!.length, (index) {
                  final DateTime fromTimeUtc = model[index]['fromTime'];
                  final DateTime toTimeUtc = model[index]['toTime'];

                  DateTime fromTime = fromTimeUtc.toLocal();
                  DateTime toTime = toTimeUtc.toLocal();

                  var fromTimeText = DateFormat.jm().format(fromTime);
                  var toTimeText = DateFormat.jm().format(toTime);
                  var timingsText = '$fromTimeText - $toTimeText';

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      selected: model[index]['isSelected'],
                      onSelected: (selected) {
                        if (selected) {
                          bloc.selectSlot(index);
                        }
                      },
                      label: Text(timingsText),
                    ),
                  );
                }),
              ),
            ],
          );
        });
  }
}
