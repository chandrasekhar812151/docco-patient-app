import 'package:doctor_patient/bloc/password_reset_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/pages/reset_password/otp_page.dart';
import 'package:doctor_patient/widgets/phone_number_editor.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPhoneNumberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = sl<PasswordResetBloc>();
    return StreamBuilder<String>(
        stream: bloc.data,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Reset Password'),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Enter your phone number',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              onChanged: (n) {
                                bloc.phone.add(n);
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  labelText: 'Phone',
                                  hintText: 'Enter you phone number',
                                  prefixIcon: Icon(Icons.phone),
                                  helperText: 'Ex: 91545454545454',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                            SizedBox(height: 8),
                            snapshot.hasError
                                ? Text(
                                    snapshot.error.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: Colors.red),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            // padding: EdgeInsets.all(16),
                            child: Text('NEXT'),
                            onPressed: () {
                              bloc.requestOtp(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtpPage()),
                                );
                              });
                            }),
                      )
                    ]
                        .map((f) => Container(
                              padding: EdgeInsets.only(bottom: 32),
                              child: f,
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
