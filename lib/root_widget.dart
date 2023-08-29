import 'package:doctor_patient/routes.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:flutter/material.dart';

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('in RootWidget build function');

    ThemeData getTheme() {
      return ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        canvasColor: Colors.white,
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange).copyWith(secondary: Colors.deepOrangeAccent), textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.deepOrange, selectionHandleColor: Colors.deepOrangeAccent,),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Docco',
      theme: getTheme(),
      initialRoute: UIData.splashRoute,
      routes: Routes.routes,
      onUnknownRoute: (RouteSettings rs) => MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text(
                      'Route "${rs.name}" not found',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
          ),
    );
  }
}
