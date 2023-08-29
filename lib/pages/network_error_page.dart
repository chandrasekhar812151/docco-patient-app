import 'package:flutter/material.dart';
import 'package:doctor_patient/uidata.dart';

class NetworkErrorPage extends StatelessWidget {
  final Function onRetry;

  NetworkErrorPage({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 24),
            Text(
              getErrorMessage(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('RETRY'),
              onPressed:()=> onRetry
            )
          ],
        ),
      ),
    );
  }

  String getErrorMessage() {
    return 'Cannot connect to server';
  }
}
