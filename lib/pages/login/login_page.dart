import 'package:doctor_patient/bloc/register_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/docco_exception.dart';
import 'package:doctor_patient/pages/register/phone_number_page.dart';
import 'package:doctor_patient/pages/reset_password/forgot_password_phone_number_page.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:doctor_patient/util/firebase_messaging.dart';
import 'package:doctor_patient/widgets/phone_number_editor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseMessaging? _firebaseMessaging = FirebaseMessaging.getInstance();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  var usernameCtrl = TextEditingController(),
      passwordCtrl = TextEditingController();

  var scaffoldContext;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Builder(builder: (scaffoldContext) {
        this.scaffoldContext = scaffoldContext;
        return SafeArea(
          child: SizedBox.expand(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: FractionallySizedBox(
                    widthFactor: 0.2,
                    child: Image.asset(UIData.logoImage),
                  ),
                ),
                Text(
                  'SIGN IN',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.orange),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: usernameCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    labelText: 'Phone',
                    hintText: 'Enter your phone number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: passwordCtrl,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        semanticLabel:
                            _obscureText ? 'show password' : 'hide password',
                      ),
                    ),
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ForgotPasswordPhoneNumberPage()));
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  // padding: EdgeInsets.symmetric(vertical: 18),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(30)),
                  child: const Text('Login'),
                  onPressed: () => _handleDefaultSignIn(),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'OR',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: theme.primaryColor, height: 1.2),
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  // padding: EdgeInsets.all(14),
                  // color: Colors.blue,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(30)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.google),
                      SizedBox(width: 8),
                      Text('Sign in with Google')
                    ],
                  ),
                  onPressed: () => _handleGoogleSignIn(),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                    // padding: EdgeInsets.symmetric(vertical: 18),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(30)),
                    child: const Text('New to Docco360? Register here'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneNumberPage()));
                    }),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _handleDefaultSignIn() async {
    if (usernameCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
          const SnackBar(content: Text('Please enter both username and password!')));
      return;
    }

    print('username: ${usernameCtrl.text}\n');
    print('password: ${passwordCtrl.text}');

    try {
      final response = await Repository.login({
        'username': usernameCtrl.text,
        'password': passwordCtrl.text,
        'fcm_token': await _firebaseMessaging?.getToken(),
        'voip_token': await _firebaseMessaging?.getVoipToken(),
        'timezone_offset': DateTime.now().timeZoneOffset.inSeconds.toString()
      });

      await _saveUserData(response);

      Navigator.of(context).pop();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(UIData.homeRoute, (route) => false);
    } on DoccoException catch (e) {
      if (e.getCode() == 500) {
        showErrorDialog(
            title: 'Unknown error occurred',
            text:
                'Cannot login due to unknown error!\nUnknown error occurred!');
      } else if (e.getCode() == 422 || e.getCode() == 401) {
        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
            SnackBar(content: Text(e.getMessage() ?? 'Login error!')));
      } else {
        showErrorDialog(
          title: 'Error occurred',
          text: e.getMessage() ?? 'Login error',
        );
      }
    } catch (e) {
      print('Cannot login');
      print(e);
      showErrorDialog(
        title: 'Error occurred',
        text: e.toString(),
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    _showLoadingDialog('Just a minute...');

    var fcmToken = await _firebaseMessaging?.getToken();
    var account;

    try {
      account = await _googleSignIn.signIn();
    } catch (e) {
      print(e);
      return;
    }

    Navigator.of(context).pop();

    if (account == null) {
      return;
    }

    try {
      print('received email ${account.email}');

      final response = await Repository.loginWithGoogle({
        'email': account.email,
        'name': account.displayName,
        'fcm_token': fcmToken,
        'voip_token': await _firebaseMessaging?.getVoipToken(),
        'timezone_offset': DateTime.now().timeZoneOffset.inSeconds.toString(),
      });

      await _saveUserData(response);

      Navigator.of(context).pop();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(UIData.homeRoute, (route) => false);
    } on DoccoException catch (e) {
      if (e.getCode() == 500) {
        showErrorDialog(
            title: 'Unknown error occurred',
            text:
                'Cannot login due to unknown error!\nUnknown error occurred!');
      } else if (e.getCode() == 422) {
        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
            SnackBar(content: Text(e.getMessage() ?? 'Login error!')));
      } else if (e.getCode() == 401) {
        final bloc = sl<RegisterBloc>();
        bloc.registerModel.email = account.email;
        bloc.registerModel.name = account.displayName;
        bloc.registerModel.fcmToken = fcmToken!;
        bloc.registerModel.timezoneOffset =
            DateTime.now().timeZoneOffset.inSeconds.toString();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PhoneNumberPage()));
      } else {
        showErrorDialog(
          title: 'Error occurred',
          text: e.getMessage() ?? 'Login error',
        );
      }
    } catch (e) {
      print('Cannot login');
      print(e);
      showErrorDialog(
        title: 'Error occurred',
        text: e.toString(),
      );
    }
  }

  Future<Null> _saveUserData(response) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', 'Bearer ${response["token"]}');
    prefs.setString('username', response['username']);
    prefs.setString('email', response['email']);
    prefs.setString('phone', response['phone']);
    prefs.setString('avatar', response['avatar']);
    prefs.setString('currency', response['currency']);
  }

  void showErrorDialog({title, text}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(text),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  void _showLoadingDialog(text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  children: <Widget>[
                    const CircularProgressIndicator(),
                    const SizedBox(width: 16),
                    Text(text),
                  ],
                ),
              ),
            ));
  }
}
