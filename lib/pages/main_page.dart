import 'package:doctor_patient/notification_handler.dart';
import 'package:doctor_patient/pages/appointments/appointments_page.dart';
import 'package:doctor_patient/pages/home/home_page.dart';
import 'package:doctor_patient/pages/profile/profile_page.dart';
import 'package:doctor_patient/resources/prefs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:doctor_patient/keys.dart' as keys;

class MainPage extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? username, avatar;

  int _currentIndex = 0;

  void getUserData() async {
    username = await Prefs.getUsername();
    avatar = await Prefs.getAvatar();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future(() {
      // NotificationHandler(context);
    });

    getUserData();

    _currentIndex = 0;
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Main page build() function called');
    List<Widget> widgets = [
      HomePage(),
      AppointmentsPage(),
      ProfilePage(),
    ];
    return Scaffold(
      key: keys.scaffoldKey,
      appBar: AppBar(
        title: Text('Docco360'),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) {
              return ['Privacy Policy', 'Terms & Conditions'].map((choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            onSelected: (item) async {
              switch (item) {
                case 'Privacy Policy':
                case 'Terms & Conditions':
                  // ignore: deprecated_member_use
                  await launch('http://docco.janaspandana.co.in/privacyPolicy.html');
              }

            },
          )
        ],
      ),
      body: Container(
        child: widgets[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('MainPage disposed');
  }


}
