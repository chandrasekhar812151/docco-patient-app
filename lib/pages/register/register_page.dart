import 'package:doctor_patient/bloc/register_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/models/register_model.dart';
import 'package:doctor_patient/util/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:doctor_patient/docco_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() {
    return new _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseMessaging? _firebaseMessaging = FirebaseMessaging.getInstance();

  var scaffoldContext;

  var nameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var phoneString = '';

  bool _obscureText = true;

  void onSubmit(context, RegisterModel model) async {
    _showLoadingDialog();

    try {
      var fcmToken = await _firebaseMessaging?.getToken();
      var decoded = await Repository.register({
        'name': nameCtrl.text,
        'email': emailCtrl.text,
        'phone': model.phone,
        'password': passwordCtrl.text,
        'fcm_token': fcmToken,
        'timezone_offset': DateTime.now().timeZoneOffset.inSeconds.toString(),
      });

      final token = decoded['token'];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', 'Bearer $token');
      prefs.setString('username', decoded['username']);
      prefs.setString('email', decoded['email']);
      prefs.setString('phone', decoded['phone']);

      Navigator.pop(context);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(UIData.homeRoute, (route) => false);
    } on DoccoException catch (e) {
      if (e.getCode() == 500) {
        Navigator.pop(context);
        debugPrint(e.getMessage());
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
        Navigator.pop(context);
        ScaffoldMessenger.of(scaffoldContext)
            .showSnackBar(SnackBar(content: Text(e.getMessage().toString())));
      } else {
        Navigator.pop(context);
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
      Navigator.pop(context);
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
  }

  @override
  Widget build(BuildContext context) {
    final bloc = sl<RegisterBloc>();
    return StreamBuilder<RegisterModel>(
        stream: bloc.register,
        initialData: RegisterModel(),
        builder: (context, snapshot) {
          nameCtrl.text = snapshot.data!.name;
          emailCtrl.text = snapshot.data!.email;
          passwordCtrl.text = snapshot.data!.password;
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
                      TextField(
                        onChanged: (name) {
                          bloc.registerModel.name = name;
                        },
                        controller: nameCtrl,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          labelText: 'Name',
                          hintText: 'Enter your name',
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 24.0),
                      TextField(
                        onChanged: (c) {
                          bloc.registerModel.email = c;
                        },
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          labelText: 'Email (Optional)',
                          hintText: 'Enter you email',
                          prefixIcon: Icon(Icons.mail),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 24.0),
                      TextField(
                        onChanged: (c) {
                          bloc.registerModel.password = c;
                        },
                        controller: passwordCtrl,
                        keyboardType: TextInputType.text,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          labelText: 'Password',
                          hintText: 'Enter your password',
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
                          child: Text('SIGN UP'),
                          onPressed: () => onSubmit(context, snapshot.data as RegisterModel)),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  void _showLoadingDialog() {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(width: 16),
                    Text('Loading...')
                  ],
                ),
              ),
            ));
  }
}
