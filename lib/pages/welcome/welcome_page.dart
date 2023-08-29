// ignore_for_file: unnecessary_statements

import 'package:doctor_patient/pages/register/phone_number_page.dart';
import 'package:flutter/material.dart';
import 'package:doctor_patient/uidata.dart';

class _CustomButton extends StatelessWidget {
  final String name;
  final Function onPressed;

  _CustomButton({required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Text(name),
        onPressed:() {
          onPressed;
          },
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {    
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        // color: Colors.white,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.3,
              0.5,
            ],
            colors: [
              Colors.orange,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SizedBox.expand(
            child: Column(
              children: <Widget>[
                SizedBox(height: 48.0),

                FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Image.asset(UIData.signInImage),
                ),

                SizedBox(height: 24.0),

                Text('WELCOME TO',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: theme.primaryColor)),

                SizedBox(height: 16.0),

                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Image.asset(UIData.logoFullImage),
                ),

                SizedBox(height: 16.0),

                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Text(
                    'Consult a Homeopathic or Ayurvedic Doctor from the Comfort of your Home',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: theme.primaryColor, height: 1.2),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 16.0),

                // register button
                ElevatedButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhoneNumberPage()));
                }, child: Text("REGISTER")),
                // _CustomButton(
                //     name: 'REGISTER',
                //     onPressed: () {
                //       print("hi");
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => PhoneNumberPage()));
                //     }),

                SizedBox(height: 24.0),

                // sign button
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, UIData.loginRoute);
                }, child: Text("SIGN IN")),
                // _CustomButton(
                //     name: 'SIGN IN',
                //     onPressed: () {
                //       Navigator.pushNamed(context, UIData.loginRoute);
                //     }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
