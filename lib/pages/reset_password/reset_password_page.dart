import 'package:doctor_patient/bloc/password_reset_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  ResetPasswordPageState createState() {
    return new ResetPasswordPageState();
  }
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 28),
                      child: snapshot.hasError
                          ? Text(
                              snapshot.error.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: Colors.red),
                            )
                          : Container(),
                    ),
                    TextField(
                      onChanged: (p) {
                        print('onchanged');
                        bloc.newPassword.add(p);
                      },
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                          labelText: 'New Password',
                          hintText: 'Your new password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              semanticLabel: _obscurePassword
                                  ? 'show password'
                                  : 'hide password',
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(height: 28),
                    TextField(
                      onChanged: (p) {
                        bloc.confirmNewPassword.add(p);
                      },
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                          labelText: 'Confirm New Password',
                          hintText: 'Confirm password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                            child: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              semanticLabel: _obscureConfirmPassword
                                  ? 'show password'
                                  : 'hide password',
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // padding: EdgeInsets.all(18),
                        child: Text('DONE'),
                        onPressed: () {
                          bloc.resetPassword(
                            () {
                              showDialog(
                            barrierDismissible: false,
                                context: context,
                                builder: (context) => Dialog(
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.check_circle, color: Colors.green),
                                                SizedBox(width: 4),
                                                Text(
                                                  'Success!',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge?.copyWith(
                                                        color: Colors.green
                                                      )
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 24),
                                            Text('Your password has been reset.'),
                                            SizedBox(height: 24),
                                            ElevatedButton(
                                                // padding: EdgeInsets.all(16),
                                                child: Text('LOGIN'),
                                                onPressed: () {
                                                  Navigator.popUntil(context, ModalRoute.withName(UIData.loginRoute));
                                                },
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
