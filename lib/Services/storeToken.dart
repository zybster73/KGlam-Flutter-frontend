import 'package:shared_preferences/shared_preferences.dart';

class Storetoken {
  static Future<void> saveToken(String access) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', access);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<void> saveId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', id);
  }

  static Future<int?> getsaveId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }
}
