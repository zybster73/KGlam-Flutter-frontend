import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String onboarding = 'onBoardingshown';
  static const String loggedIn = 'isLoggedIn';
  static const String role = 'userRole';

  // Set  bool
  static Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Get  bool
  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  // Set role
  static Future<void> setRole(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(role, value);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(role);
  }

static Future<void> removeRole() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(role);
}

 
}
