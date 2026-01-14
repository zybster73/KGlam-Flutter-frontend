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

  Future<Map<String, dynamic>> signUp(
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
        Utils.instance.toastMessage(responseData['msg']);
        print(response.body);
        return {
          'success': true,
          'message': responseData['msg'],
          'data': responseData,
        };
      } else {
        String message = '';
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          message = responseData['errors'][firstField][0];
        } else if (responseData['msg'] != null) {
          message = responseData['msg'];
        }
        Utils.instance.toastMessage(message);
        print(response.body);
        return {'success': false, 'message': message,'errors': responseData['errors'], };
      }
    } catch (e) {
      Utils.instance.toastMessage(e.toString());
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> verifyEmail(String otpController) async {
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse(url + 'verify-signup/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'otp': otpController}),
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData['msg']);
        print(response.body);
        return {
          'success': true,
          'message': responseData['msg'],
          'data': responseData,
        };
      } else {
        String message = '';
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          message = responseData['errors'][firstField][0];
        } else if (responseData['msg'] != null) {
          message = responseData['msg'];
        }
        Utils.instance.toastMessage(message);
        print(response.body);
        return {'success': false, 'message': message};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> loginApi(
    String email_username_password,
    String password,
  ) async {
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
      var salonId = responseData['data']?['salon']?['salon_id'];

      if (salonId != null) {
        await Storetoken.saveSalonId(salonId);
        print(salonId);
      } else {
        print('token is not saved');
      }

      if (response.statusCode == 200) {
        Utils.instance.toastMessage('Login Successfully');
        print(response.body);
        var accessToken = responseData['tokens']?['access'];
        var refreshToken = responseData['tokens']?['refresh'];
        if (accessToken != null) {
          await Storetoken.saveToken(accessToken);
          await Storetoken.saveRefreshToken(refreshToken);
          print(refreshToken);
          print(accessToken);
        } else {
          print('token is not saved');
        }
        return {
          'success': true,
          'message': 'Login Successfully',
          'data': responseData,
        };
      } else {
        String message = '';
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          message = responseData['errors'][firstField][0];
        } else if (responseData['msg'] != null) {
          message = responseData['msg'];
        }
        Utils.instance.toastMessage('invalid credentials');
        print(response.body);
        return {'success': false, 'message': message};
      }
    } catch (e) {
      Utils.instance.toastMessage('invalid credentials');
      print(e.toString());
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String emailOrphonenumber) async {
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
        return {
          'success': true,
          'message': responseData['msg'],
          'data': responseData,
        };
      } else {
        String message = '';
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstfield = responseData['errors'].keys.first;
          message = responseData['errors'][firstfield][0];
        } else if (responseData['msg'] != null) {
          message = responseData['msg'];
        }
        print(response.body);
        Utils.instance.toastMessage(message);
        return {'success': false, 'message': message};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
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
        print(response.body);
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
        print(response.body);
        return null;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return null;
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> resetPassowrd(
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
        print(response.body);
        return {
          'success': true,
          'message': responseData['msg'],
          'data': responseData,
        };
      } else {
        String message = '';
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          message = responseData['errors'][firstField][0];
        } else if (responseData['msg'] != null) {
          message = responseData['msg'];
        }
        Utils.instance.toastMessage(message);
        print(response.body);
        return {'success': false, 'message': message};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> resendOtp(String email_username) async {
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse(url + 'resend-otp/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'username_or_email': email_username}),
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData['msg']);
        print(response.body);
        return {
          'success': true,
          'message': responseData['msg'],
          'data': responseData,
        };
      } else {
        String message = '';
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          message = responseData['errors'][firstField][0];
        } else if (responseData['msg'] != null) {
          message = responseData['msg'];
        }
        Utils.instance.toastMessage(message);
        print(response.body);
        return {'success': false, 'message': message};
      }
    } catch (e) {
      print(e);
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> resendOtpatsignUp(String email_username) async {
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse(url + 'resend-signup-otp/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email_username}),
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData['msg']);
        print(response.body);
        return {
          'success': true,
          'message': responseData['msg'],
          'data': responseData,
        };
      } else {
        String message = '';
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          message = responseData['errors'][firstField][0];
        } else if (responseData['msg'] != null) {
          message = responseData['msg'];
        }
        Utils.instance.toastMessage(message);
        print(response.body);
        return {'success': false, 'message': message};
      }
    } catch (e) {
      print(e);
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> logout(String? refreshtoken) async {
    String? token = await Storetoken.getToken();
    String? refreshToken = await Storetoken.getRefreshToken();
    setLoading(true);
    try {
      Response response = await http.post(
        Uri.parse(url + 'logout/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'refresh': refreshtoken}),
      );

      var responseData = jsonDecode(response.body);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 205 ) {
        Utils.instance.toastMessage(responseData['msg']);
        print(response.body);

        return {
          'success': true,
          'message': responseData['msg'],
          'data': responseData,
        };
      } else {
        String message = '';
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          message = responseData['errors'][firstField][0];
        } else if (responseData['msg'] != null) {
          message = responseData['msg'];
        } else {
          message = 'Logout failed';
        }

        Utils.instance.toastMessage(message);
        print(response.body);

        return {'success': false, 'message': message};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }
}
