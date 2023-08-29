import 'package:doctor_patient/models/doctor.dart';
import 'package:doctor_patient/pages/image_full_view.dart';
import 'package:doctor_patient/widgets/profile_picture.dart';
import 'package:flutter/material.dart';

class BasicInfoWidget extends StatelessWidget {
  const BasicInfoWidget(this.data, {super.key});

  final Doctor data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          margin: const EdgeInsets.all(0),
          child: Container(
            margin: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (data.avatar == null) {
                      return;
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageFullView(data.avatar.toString())));
                  },
                  child: ProfilePicture.circular(data.avatar, radius: 36),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${data.firstName} ${data.lastName ?? ''}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    data.title != null
                        ? SizedBox(
                            width: 200,
                            child: Text(
                              data.title.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
