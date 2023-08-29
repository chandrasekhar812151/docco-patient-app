import 'package:doctor_patient/bloc/register_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/docco_exception.dart';
import 'package:doctor_patient/models/register_model.dart';
import 'package:doctor_patient/pages/register/otp_page.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:flutter/material.dart';

class PhoneNumberPage extends StatefulWidget {
  @override
  _PhoneNumberPageState createState() {
    return new _PhoneNumberPageState();
  }
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final List<Map<String, String>> _countries = [
    {"name": "India", "code": "91"},
    {"name": "New Zealand", "code": "64"},
    {"name": "United Arab Emirates", "code": "971"},
    {"name": "United Kingdom", "code": "44"},
    {"name": "United States", "code": "1"},
  ];

  final phoneCtrl = TextEditingController();

  var scaffoldContext;
  var _countryCode;

  bool buttonDisabled = false;
  var _phoneString;

  @override
  void initState() {
    super.initState();
    _countryCode = '91';
  }

  void onSubmit(context) async {
    if (phoneCtrl.text.isEmpty) {
      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
          SnackBar(content: Text('Please provide your phone number')));
      return;
    }

    setState(() {
      buttonDisabled = true;
    });

    try {
      await Repository.requestOtp(
          {'phone': _phoneString, 'reason': 'new_account'});

      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage()));
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
          return Scaffold(
            body: Builder(builder: (scaffoldContext) {
              this.scaffoldContext = scaffoldContext;
              return SafeArea(
                child: SizedBox.expand(
                  child: ListView(
                    padding: EdgeInsets.all(8),
                    children: <Widget>[
                      FractionallySizedBox(
                        widthFactor: 0.25,
                        child: Image.asset(UIData.logoImage),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'REGISTER WITH US',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.deepOrange),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text('Country',
                                style: Theme.of(context).textTheme.bodySmall),
                            DropdownButton(
                                value: _countryCode,
                                isExpanded: true,
                                onChanged: (c) {
                                  setState(() {
                                    _countryCode = c;
                                  });
                                },
                                items: _countries
                                    .map((c) => DropdownMenuItem(
                                          child: Text(c['name'].toString()),
                                          value: c['code'],
                                        ))
                                    .toList()),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.0),
                      TextField(
                        onChanged: (s) {
                          _phoneString = '$_countryCode${phoneCtrl.text}';
                          bloc.registerModel.phone = _phoneString;
                        },
                        controller: phoneCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          labelText: 'Phone',
                          hintText: 'Enter your phone number',
                          helperText: 'Example +915454545454',
                          prefixText: '+$_countryCode',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 24.0),
                      ElevatedButton(
                          // padding: EdgeInsets.symmetric(vertical: 18),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(30)),
                          child: Text('CONTINUE'),
                          onPressed:
                              buttonDisabled ? null : () => onSubmit(context)),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                          // padding: EdgeInsets.symmetric(vertical: 18),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(30)),
                          child: Text('Already Registered? Login here'),
                          onPressed: () {
                            Navigator.pushNamed(context, UIData.loginRoute);
                          }),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
}
