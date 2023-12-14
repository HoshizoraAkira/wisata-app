import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_app/screens/dashboard_screen.dart';
import 'package:wisata_app/screens/login_screen.dart';

class SessionManager {
  static SessionManager? _instance;
  static SharedPreferences? _preferences;

  static Future<void> saveData(String token, String firstName, String email, String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setBool('isLogin', true);
    prefs.setString('firstName', firstName);
    prefs.setString('email', email);
    prefs.setString('username', username);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<SessionManager> getInstance() async {
    _instance ??= SessionManager();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  Future<void> isLogin(BuildContext context) async {
    await getInstance();
    bool isLogin = _preferences!.getBool('isLogin') ?? false;
    if (isLogin) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
        (route) => false,
      );
    }
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    await getInstance();
    bool isLogin = _preferences!.getBool('isLogin') ?? false;

    if (!isLogin) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  Future<void> saveUserData(String username) async {
    await _preferences!.setBool('isLogin', true);
    await _preferences!.setString('username', username);
  }

  String? getEmail() {
    return _preferences!.getString('email');
  }

  String? getUsername() {
    return _preferences!.getString('username');
  }

  getIsLogin() {
    return _preferences!.getBool('isLogin');
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("isLogin");
    prefs.remove("username");
    prefs.remove("token");
    prefs.remove("firstName");
    prefs.clear();
  }
}
