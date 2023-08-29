import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/bloc/slots_bloc.dart';
import 'package:doctor_patient/models/doctor.dart';
import 'package:doctor_patient/widgets/profile_picture.dart';
import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = sl<SlotsBloc>();
    return StreamBuilder<Doctor>(
        stream: bloc.doctorStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }

          final model = snapshot.data;
          return Card(
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  ProfilePicture.circular(model?.avatar, radius: 28),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${model?.firstName} ${model?.lastName ?? ''}'
                            .trim(),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      model?.title != null
                          ? Container(
                              width: 200,
                              child: Text(
                                model!.title.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.grey),
                              ),
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
