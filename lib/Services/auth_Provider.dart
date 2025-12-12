import 'dart:convert';

import 'package:KGlam/Services/Base_Urls.dart';
import 'package:KGlam/Services/storeToken.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  

  final url = BaseUrls.baseUrl;

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool> signUp(
    String username,
    String email,
    String phoneNumber,
    String password,
    String confirmPassword,
    String? role,
  ) async {
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse(url + "signup/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'temp_username': username,
          'temp_email': email,
          'temp_contact_number': phoneNumber,
          'temp_password': password,
          'temp_confirm_password': confirmPassword,
          'temp_role': role,
        }),
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        Utils.instance.toastMessage(responseData['msg']);
        return true;
      } else {
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;

          String errorMessage = responseData['errors'][firstField][0];

          Utils.instance.toastMessage(errorMessage);
        } else if (responseData['msg'] != null) {
          Utils.instance.toastMessage(responseData['msg']);
        }

        print(response.body);

        return false;
      }
    } catch (e) {
      Utils.instance.toastMessage(e.toString());
    } finally {
      setLoading(false);
      // notifyListeners();
    }
    return false;
  }

  Future<bool> verifyEmail(String otpController) async {
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse(url + 'verify-signup/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'otp': otpController}),
      );
      print("VERIFY STATUS: ${response.statusCode}");
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData['msg']);
        print("VERIFY STATUS: ${response.statusCode}");
        return true;
      } else {
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          String errorMessage = responseData['errors'][firstField][0];
          Utils.instance.toastMessage(errorMessage);
        } else if (responseData['msg'] != null) {
          Utils.instance.toastMessage(responseData['msg']);
        }
        print(response.body);
        return false;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
    } finally {
      setLoading(false);
      // notifyListeners();
    }
    return false;
  }

  Future<bool> loginApi(String email_username_password, String password) async {
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse(url + 'login/'),
        headers: {"Content-Type": "application/json"},

        body: jsonEncode({
          'username_email_contact': email_username_password,
          'password': password,
        }),
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.instance.toastMessage('Login Successfully');
        print(response.body);

        var accessToken = responseData['tokens']?['access'];

        await Storetoken.saveToken(accessToken);

        if (accessToken != null) {
          await Storetoken.saveToken(accessToken);
          print("Saved token: $accessToken");
        }

        return true;
      } else {
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          String errorMessage = responseData['errors'][firstField][0];
          Utils.instance.toastMessage(errorMessage);
        } else if (responseData['msg'] != null) {
          Utils.instance.toastMessage(responseData['msg']);
        }
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return false;
    } finally {
      setLoading(false);
      // notifyListeners();
    }
    return false;
  }

  Future<bool> forgotPassword(String emailOrphonenumber) async {
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse(url + 'send-otp/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'username_or_email': emailOrphonenumber}),
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData['msg']);
        print(response.body);
        return true;
      } else {
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstfield = responseData['errors'].keys.first;

          String errorMessage = responseData['errors'][firstfield][0];

          Utils.instance.toastMessage(errorMessage);
        } else if (responseData['msg'] != null) {
          Utils.instance.toastMessage(responseData['msg']);
        }

        print(response.body);

        return false;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
    } finally {
      setLoading(false);
      // notifyListeners();
    }
    return false;
  }

  Future<String?> forgotEmailOtp(String otp) async {
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse(url + 'verify-otp/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'otp': otp}),
      );

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData['msg']);

        return responseData["reset_token"];
      } else {
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstfield = responseData['errors'].keys.first;

          String errorMessage = responseData['errors'][firstfield][0];

          Utils.instance.toastMessage(errorMessage);
        } else if (responseData['msg'] != null) {
          Utils.instance.toastMessage(responseData['msg']);
        }
        return null;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return null;
    } finally {
      setLoading(false);
      // notifyListeners();
    }
  }

  Future<bool> resetPassowrd(
    String password,
    String confirmPass,
    String resetToken,
  ) async {
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse(url + 'reset-password/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'reset_token': resetToken,
          'password': password,
          'confirm_password': confirmPass,
        }),
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData['msg']);
        return true;
      } else {
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          String errorMessage = responseData['errors'][firstField][0];
          Utils.instance.toastMessage(errorMessage);
        } else if (responseData['msg'] != null) {
          Utils.instance.toastMessage(responseData['msg']);
        }
        print(response.body);
        return false;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
    } finally {
      setLoading(false);
    // notifyListeners();
    }
    return false;
  }

  Future<bool> resendOtp(String email_username) async {
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse(url + 'resend-otp/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email_or_username': email_username}),
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData['msg']);
        return true;
      } else {
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          String errorMessage = responseData['errors'][firstField][0];
          Utils.instance.toastMessage(errorMessage);
        } else if (responseData['msg'] != null) {
          Utils.instance.toastMessage(responseData['msg']);
        }
        print(response.body);
        return false;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
    } finally {
      setLoading(false);
      // notifyListeners();
    }
    return false;
  }
}
