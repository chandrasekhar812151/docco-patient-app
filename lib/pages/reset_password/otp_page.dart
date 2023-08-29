import 'package:doctor_patient/bloc/password_reset_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/pages/reset_password/reset_password_page.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = sl<PasswordResetBloc>();
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
                        'Please enter the OTP sent to your mobile.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 48),
                              child: TextField(
                                  onChanged: (otp) {
                                    bloc.otp.add(otp);
                                  },
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 8),
                                  maxLength: 4,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      prefixText: '   ',
                                      suffixText: '   ',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)))),
                            ),
                            SizedBox(height: 4),
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
                            bloc.verifyOtp(() {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPasswordPage()),
                              );
                            });
                          },
                        ),
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
