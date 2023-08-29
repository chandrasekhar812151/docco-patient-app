
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<String?> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }

  static Future<String?> getAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('avatar');
  }

  static Future<String?> getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('currency');
  }

  static Future<bool> deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}