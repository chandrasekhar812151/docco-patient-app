import 'package:doctor_patient/bloc/register_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/docco_exception.dart';
import 'package:doctor_patient/models/register_model.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() {
    return new _OtpPageState();
  }
}

class _OtpPageState extends State<OtpPage> {
  var scaffoldContext;
  var otpCtrl = TextEditingController();

  bool buttonDisabled = false;
  bool _obscureText = true;

  void onSubmit(context, RegisterBloc bloc, RegisterModel model) async {
    bloc.registerModel.otp = otpCtrl.text;

    setState(() {
      buttonDisabled = true;
    });

    try {
      await Repository.verifyOtp({'otp': otpCtrl.text, 'phone': model.phone});

      Navigator.pushNamed(context, UIData.registerRoute);
    } on DoccoException catch (e) {
      if (e.getCode() == 500) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Unknown error occurred'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Cannot login due to unknown error!'),
                      Text('Please try again later.'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
        );
      } else if (e.getCode() == 422) {
        ScaffoldMessenger.of(scaffoldContext)
            .showSnackBar(SnackBar(content: Text(e.getMessage().toString())));
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Error occurred'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(e.getMessage().toString()),
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      print('Cannot create account');
      print(e);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Error occurred'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Unknown error occurred!'),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
      );
    }

    setState(() {
      buttonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = sl<RegisterBloc>();
    return StreamBuilder<RegisterModel>(
        stream: bloc.register,
        initialData: RegisterModel(),
        builder: (context, snapshot) {
          print('received from stream ${snapshot.data?.phone}');
          return Scaffold(
            body: Builder(builder: (scaffoldContext) {
              this.scaffoldContext = scaffoldContext;
              return SafeArea(
                child: SizedBox.expand(
                  child: ListView(
                    padding: EdgeInsets.all(8),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 36),
                        child: FractionallySizedBox(
                          widthFactor: 0.4,
                          child: Image.asset(UIData.logoImage),
                        ),
                      ),
                      Text(
                        'REGISTER WITH US',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.deepOrange),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        controller: otpCtrl,
                        keyboardType: TextInputType.number,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          labelText: 'OTP',
                          hintText: 'Enter OTP',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              semanticLabel: _obscureText
                                  ? 'show password'
                                  : 'hide password',
                            ),
                          ),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 24.0),
                      ElevatedButton(
                          // padding: EdgeInsets.symmetric(vertical: 18),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(30)),
                          child: Text('CONTINUE'),
                          onPressed: buttonDisabled
                              ? null
                              : () => onSubmit(context, bloc, snapshot.data as RegisterModel)),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
}
