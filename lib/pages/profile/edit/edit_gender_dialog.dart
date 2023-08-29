import 'package:doctor_patient/bloc/profile_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/docco_exception.dart';
import 'package:doctor_patient/models/profile.dart';
import 'package:flutter/material.dart';

class EditGenderDialog extends StatefulWidget {
  final Profile profile;

  EditGenderDialog(this.profile);

  @override
  BloodGroupDialogState createState() => new BloodGroupDialogState();
}

class BloodGroupDialogState extends State<EditGenderDialog> {
  var gender;

  Future<Null> _onSave(ProfileBloc bloc) async {
    try {
      await bloc.updateProperty({
        'gender': gender,
      });

      // Scaffold.of(scaffoldContext)
      //     .showSnackBar(SnackBar(content: Text('Updated')));
      Navigator.pop(context);
    } on DoccoException catch (e) {
      if (e.getCode() == 422) {
        // Scaffold.of(scaffoldContext)
        //     .showSnackBar(SnackBar(content: Text(e.getMessage())));
      } else if (e.getCode() == 500) {
        // Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
        //     content: Text('Cannot update profile due to server error!')));
      }
    } catch (e) {
      print(e);
      // Scaffold.of(scaffoldContext).showSnackBar(
      //     SnackBar(content: Text('Cannot update profile due to error!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = sl<ProfileBloc>();
    bloc.getProfile();

    return StreamBuilder<Profile>(
      stream: bloc.profile,
      builder: (context, snapshot) {
        return new Scaffold(
          appBar: new AppBar(
            // title: const Text('New entry'),
            actions: [
              new ElevatedButton(
                  onPressed: () => _onSave(bloc),
                  child: new Text('SAVE',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white))),
            ],
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 28),
                new Text('Your Gender',
                    style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton<String>(
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        gender = value;
                      });
                    },
                    hint: Text('Gender'),
                    value: gender ?? snapshot.data?.gender,
                    items: [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text('Female'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
