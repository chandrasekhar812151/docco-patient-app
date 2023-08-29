// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:doctor_patient/resources/prefs.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:flutter/material.dart';
import 'package:doctor_patient/docco_exception.dart';

class CustomErrorWidget extends StatefulWidget {
  final Object e;
  final Function onRetry;

  CustomErrorWidget(this.e, {required this.onRetry});

  @override
  _CustomErrorWidgetState createState() => _CustomErrorWidgetState();
}

class _CustomErrorWidgetState extends State<CustomErrorWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.e is DoccoException) {
      print('is docco exception');
      DoccoException? e = widget.e as DoccoException?;
      print('code .... ${e?.getCode()}');
      if (e?.getCode() == 401) {
        return _SessionExpiredWidget();
      } else if (e?.getCode() == 422) {
        return _ValidationErrorWidget(e!);
      }
    } else if (widget.e.runtimeType == DioError) {
      print('it is dio error');
      DioError? e = widget.e as DioError?;
      return _NetworkErrorWidget(e!, widget.onRetry);
    } else {
      print('unknown error');
    }

    return Container();
  }
}

class _NetworkErrorWidget extends StatelessWidget {
  final Function onRetry;
  final DioError dioError;

  _NetworkErrorWidget(this.dioError, this.onRetry);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Network Error', style: textTheme.headline6),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(dioError.message.toString()),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            child: Text('RETRY'),
            onPressed: () {
              onRetry();
            },
          )
        ],
      ),
    );
  }
}

class _SessionExpiredWidget extends StatelessWidget {
  Future showLoginExpiredDialog(context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Session expired'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Your session has been expired!'),
                  Text('Please login again.'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  _logout(context);
                },
              ),
            ],
          ),
    );
  }

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
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Session Expired', style: textTheme.headline6),
          SizedBox(height: 8),
          ElevatedButton(
            child: Text('Login'),
            onPressed: () {
              Navigator.of(context).pushNamed(UIData.welcomeRoute);
            },
          )
        ],
      ),
    );
  }
}

/// validation error widget
class _ValidationErrorWidget extends StatelessWidget {
  final DoccoException e;

  _ValidationErrorWidget(this.e);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Error', style: textTheme.headline6),
          SizedBox(height: 8),
          Text(e.getMessage().toString()),
        ],
      ),
    );
  }
}
