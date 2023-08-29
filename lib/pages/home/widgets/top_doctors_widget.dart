import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_patient/models/doctor.dart';
import 'package:doctor_patient/pages/doctor_profile/doctor_profile.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:doctor_patient/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';

class TopDoctorsWidget extends StatefulWidget {
  @override
  _TopDoctorsWidgetState createState() => _TopDoctorsWidgetState();
}

class _TopDoctorsWidgetState extends State<TopDoctorsWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FutureBuilder<List<Doctor>>(
        future: Repository.getAllDoctors(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomErrorWidget(snapshot.error.toString(), onRetry: () {
              setState(() {});
            });
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final doctors = snapshot.data;
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Our Doctors',
                    style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List<Widget>.generate(doctors!.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DoctorProfile(doctorId: doctors[index].id)));
                        },
                        child: Container(
                            margin: getSpacing(index, doctors.length),
                            width: 110,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.all(0),
                              child: Stack(
                                children: <Widget>[
                                  doctors[index].avatar != null
                                      ? CachedNetworkImage(
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Image.network(
                                                    "${doctors[index].avatar}",
                                                    fit: BoxFit.fitHeight,
                                                    height: double.infinity,
                                                  ),
                                          imageUrl: "${doctors[index].avatar}",
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                UIData.userDefaultImage,
                                                fit: BoxFit.fitHeight,
                                                height: double.infinity,
                                              ),
                                          errorWidget: (context, url, error) {
                                            print('Cannot load image');
                                            return Icon(Icons.error);
                                          },
                                        )
                                      : Image.asset(
                                          UIData.userDefaultImage,
                                          fit: BoxFit.fitHeight,
                                          height: double.infinity,
                                        ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      width: double.infinity,
                                      color: Colors.black.withOpacity(0.3),
                                      child: Text(
                                        doctors[index].firstName.toString(),
                                        style: textTheme.titleMedium
                                            ?.copyWith(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 8)
              ],
            ),
          );
        });
  }

  EdgeInsetsGeometry getSpacing(index, length) {
    if (index == 0) {
      return EdgeInsets.only(left: 16, right: 4);
    } else if (index == length - 1) {
      return EdgeInsets.only(right: 16, left: 4);
    }

    return EdgeInsets.symmetric(horizontal: 4);
  }
}
