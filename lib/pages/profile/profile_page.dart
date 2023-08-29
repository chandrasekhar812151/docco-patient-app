import 'package:doctor_patient/bloc/profile_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/models/profile.dart';
import 'package:doctor_patient/pages/profile/edit/edit_age_dialog.dart';
import 'package:doctor_patient/pages/profile/edit/edit_blood_group_dialog.dart';
import 'package:doctor_patient/pages/profile/edit/edit_gender_dialog.dart';
import 'package:doctor_patient/pages/profile/edit/edit_name_dialog.dart';
import 'package:doctor_patient/pages/profile/edit/edit_weight_dialog.dart';
import 'package:doctor_patient/pages/profile/profile_image_widget.dart';
import 'package:doctor_patient/resources/prefs.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:doctor_patient/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';

class _Model {
  final Profile profile;
  String? age;
  String? gender;
  String? bloodGroup;
  String? email;
  String? weight;

  _Model(this.profile) {
    age = profile.age != null ? profile.age.toString() : 'NA';
    gender = profile.gender != null ? profile.gender.toString() : 'NA';
    bloodGroup =
        profile.bloodGroup != null ? profile.bloodGroup.toString() : 'NA';
    email = profile.email != null ? profile.email.toString() : 'NA';
    weight = profile.weight != null ? profile.weight.toString() : 'NA';
    gender = profile.gender != null ? profile.gender.toString() : 'NA';
  }
}

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Null> _logout(BuildContext context) async {
    try {
      await Repository.logout();
    } catch (e) {}

    print('came here');
    Prefs.deleteAll().then((_) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(UIData.welcomeRoute, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = sl<ProfileBloc>();
    bloc.getProfileFromServer();

    final textCaptionStyle = Theme.of(context).textTheme.bodySmall;
    final valueStyle = Theme.of(context).textTheme.titleLarge;

    return StreamBuilder<Profile>(
        stream: bloc.profile,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: CustomErrorWidget(
                    snapshot.error.toString(),
                    onRetry: () {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // padding: EdgeInsets.all(25),
                    child: Text('LOGOUT'),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content:
                                Text('Are you sure that you want to logout?'),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text('CANCEL'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              ElevatedButton(
                                child: Text('LOGOUT'),
                                onPressed: () => _logout(context),
                              )
                            ],
                          );
                        }),
                  ),
                ),
              ],
            );
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var model = _Model(snapshot.data as Profile);

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      // color: Color(0xffFF7043),
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 48),
                      padding: EdgeInsets.only(top: 24),
                      width: double.infinity,
                      // color: Colors.deepOrange,
                      child: Column(children: <Widget>[
                        ProfileImageWidget(snapshot.data as Profile),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              new MaterialPageRoute<Null>(
                                  builder: (BuildContext context) {
                                    return EditNameDialog(snapshot.data as Profile);
                                  },
                                  fullscreenDialog: true),
                            );
                          },
                          child: Text(snapshot.data!.name.toString(),
                              style: Theme.of(context).textTheme.titleLarge
                              // .copyWith(color: Colors.white),
                              ),
                        ),
                        SizedBox(height: 64),
                      ]),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 16,
                      left: 16,
                      child: Card(
                        color: Colors.orange,
                        // margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    new MaterialPageRoute<Null>(
                                        builder: (BuildContext context) {
                                          return EditAgeDialog(snapshot.data as Profile);
                                        },
                                        fullscreenDialog: true),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: <Widget>[
                                      Text(model.age.toString(), style: valueStyle),
                                      SizedBox(height: 8),
                                      Text('AGE', style: textCaptionStyle),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    new MaterialPageRoute<Null>(
                                        builder: (BuildContext context) {
                                          return EditWeightDialog(
                                              snapshot.data as Profile);
                                        },
                                        fullscreenDialog: true),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: <Widget>[
                                      Text(model.weight.toString(), style: valueStyle),
                                      SizedBox(height: 8),
                                      Text('WEIGHT', style: textCaptionStyle),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    new MaterialPageRoute<Null>(
                                      builder: (BuildContext context) {
                                        return EditBloodGroupDialog(
                                            snapshot.data as Profile);
                                      },
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: <Widget>[
                                      Text(model.bloodGroup.toString(), style: valueStyle),
                                      SizedBox(height: 8),
                                      Text('BLOOD', style: textCaptionStyle),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    new MaterialPageRoute<Null>(
                                      builder: (BuildContext context) {
                                        return EditGenderDialog(snapshot.data as Profile);
                                      },
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: <Widget>[
                                      Text(model.gender.toString(), style: valueStyle),
                                      SizedBox(height: 8),
                                      Text('GENDER', style: textCaptionStyle),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildContactDetailsWidget(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      // padding: EdgeInsets.all(25),
                      child: Text('LOGOUT'),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content:
                                  Text('Are you sure that you want to logout?'),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text('CANCEL'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                ElevatedButton(
                                  child: Text('LOGOUT'),
                                  onPressed: () => _logout(context),
                                )
                              ],
                            );
                          })),
                )
              ]
                  .map(
                    (f) => Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: f,
                        ),
                  )
                  .toList(),
            ),
          );
        });
  }

  Widget _buildContactDetailsWidget() {
    return FutureBuilder<String?>(
        future: Prefs.getPhone(),
        initialData: '',
        builder: (context, snapshot) {
          return Container(
            child: Column(
              children: <Widget>[
                Divider(height: 1),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(snapshot.data ?? 'Add phone number'),
                  ),
                ),
                Divider(height: 1),
              ],
            ),
          );
        });
  }
}
