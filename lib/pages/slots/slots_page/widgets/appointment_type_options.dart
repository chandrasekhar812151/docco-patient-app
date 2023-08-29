import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/bloc/slots_bloc.dart';
import 'package:flutter/material.dart';

class AppointmentTypeOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = sl<SlotsBloc>();
    return StreamBuilder<List<RadioModel>>(
        stream: bloc.appointmentTypesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final model = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('TYPE OF APPOINTMENT',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List<Widget>.generate(model!.length, (index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            bloc.changeAppointmentType(index);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    model[index].icon,
                                    color: model[index].isSelected
                                        ? Colors.orange
                                        : Colors.grey,
                                    size: model[index].isSelected ? 30 : 24,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    model[index].text,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: model[index].isSelected
                                              ? Colors.orange
                                              : Colors.grey,
                                          fontWeight: model[index].isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
