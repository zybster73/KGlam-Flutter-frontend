import 'package:shared_preferences/shared_preferences.dart';

class Storetoken {
  //save access token
  static Future<void> saveToken(String access) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', access);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
//save user id 
  static Future<void> saveId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', id);
  }

  static Future<int?> getsaveId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

//save service id 
  static Future<void> saveServiceId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('service_Id', id);
  }

  static Future<int?> getServiceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('service_Id');
  }

  //save salon id
  static Future<void> saveSalonId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('salon_Id', id);
  }

  static Future<int?> getSalonId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('salon_Id');
  }
  
  //save portfolio id
   static Future<void> savePortfolioId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('portfolio_Id', id);
  }

  static Future<int?> getPortfolioId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('portfolio_Id');
  }

  //save salon id at the time of salon Creation
 

}
