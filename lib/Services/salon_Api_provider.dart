import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:KGlam/Services/Base_Urls.dart';
import 'package:KGlam/Services/storeToken.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SalonApiProvider with ChangeNotifier {
  final url = BaseUrls.baseUrl;

  final url1 = BaseUrls.salonUrl;

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    String? token = await Storetoken.getToken();
    setLoading(true);
    try {
      final response = await http.get(
        Uri.parse(url + 'viewuser/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData["msg"]);
        print(response.body);
        return responseData['data'];
      } else {
        if (responseData["msg"] != null) {
          Utils.instance.toastMessage(responseData["msg"]);
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

  Future<bool> updateUserDetails(
    String oldpassword,
    String newpassowrd,
    String confirmpassrd,
  ) async {
    String? token = await Storetoken.getToken();
    setLoading(true);
    try {
      final response = await http.patch(
        Uri.parse(url + "updateinfo/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          'old_password': oldpassword,
          'new_password': newpassowrd,
          'confirm_password': confirmpassrd,
        }),
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
      //notifyListeners();
    }
    return false;
  }

  Future<bool> salonInformation(
    String salon_name,
    String salonAddress,
    String salonContact,
    String hours,
    String salonDesc,
  ) async {
    setLoading(true);

    String? token = await Storetoken.getToken();

    try {
      final response = await http.post(
        Uri.parse(url1 + 'createsalon/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          'salon_name': salon_name,
          'salon_address': salonAddress,
          'salon_contact': salonContact,
          'hours_of_operation': hours,
          'salon_desc': salonDesc,
        }),
      );
      var responseData = jsonDecode(response.body);

      var accessId = responseData['data']?['id'];

      // await Storetoken.saveId(accessId);

      if (accessId != null) {
        await Storetoken.saveId(accessId);
        await Storetoken.saveToken(accessId.toString());
        print("Saved id: $accessId");
      } else {
        print("Error: accessId is null, cannot save");
      }

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

  Future<bool> serviceInformation(
    String serviceName,
    String servicePrice,
    String serviceDuration,
    String serviceDesc,
    //String image,
  ) async {
    setLoading(true);
    String? token = await Storetoken.getToken();
    int? id = await Storetoken.getsaveId();

    try {
      final response = await http.post(
        Uri.parse(url1 + "salon/5/service/create/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },

        body: jsonEncode({
          'service_name': serviceName,
          'service_price': servicePrice,
          'service_duration': serviceDuration,
          'service_desc': serviceDesc,
          //'service_image': image,
        }),
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
    }
    return false;
  }

  Future<void> updateSolonDetails(
    String salon_name,
    String salonAddress,
    String salonContact,
    String hours,
    String salonDesc,
  ) async {
    String? token = await Storetoken.getToken();
    setLoading(true);
    try {
      final response = await http.patch(
        Uri.parse(url1 + 'updatesalon/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          'salon_name': salon_name,
          'salon_address': salonAddress,
          'salon_contact': salonContact,
          'hours_of_operation': hours,
          'salon_desc': salonDesc,
        }),
      );

      var responseData = jsonDecode(response.body);

      var accessId = responseData['data']?['id'];

      // await Storetoken.saveId(accessId);

      if (accessId != null) {
        await Storetoken.saveId(accessId);
        await Storetoken.saveToken(accessId.toString());
        print("Saved id: $accessId");
      } else {
        print("Error: accessId is null, cannot save");
      }

      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData['msg']);
        print(response.body);
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
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateService(
    String serviceName,
    String servicePrice,
    String serviceDuration,
    String serviceDesc,
  ) async {
    String? token = await Storetoken.getToken();
    setLoading(true);

    try {
      final response = await http.patch(
        Uri.parse(url1 + 'updateservice/6/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          'service_name': serviceName,
          'service_price': servicePrice,
          'service_duration': serviceDuration,
          'service_desc': serviceDesc,
        }),
      );

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData['msg']);
        print(response.body);
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
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }
}
