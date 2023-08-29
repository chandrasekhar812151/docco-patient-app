import 'package:doctor_patient/models/doctor_search_result.dart';
import 'package:doctor_patient/pages/doctor_profile/doctor_profile.dart';
import 'package:doctor_patient/widgets/profile_picture.dart';
import 'package:flutter/material.dart';

class SearchListItem extends StatelessWidget {
  final DoctorSearchResult doctor;
  SearchListItem(this.doctor);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          print('you tapped on doctor');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorProfile(doctorId: doctor.id),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ProfilePicture.circular(doctor.avatar, radius: 28),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${doctor.firstName} ${doctor.lastName ?? ''}'
                                  .trim(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 255,
                              child: Text(
                                doctor.title ?? '',
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Experience',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 4),
                      Text('20 Years'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Fees',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 4),
                      Text('20 Years'),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
