import 'dart:convert';

import 'package:KGlam/Services/Base_Urls.dart';
import 'package:KGlam/Services/storeToken.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/models/Booking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class client_Api with ChangeNotifier {
  final url1 = BaseUrls.salonUrl;

  final url2 = BaseUrls.clientUrl;

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<List<dynamic>?> viewSalons() async {
    setLoading(true);

    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url1 + "viewsalons/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.instance.toastMessage(responseData["msg"]);
        print(response.body);
        return responseData['results'];
      } else {
        if (responseData["msg"] != null) {
          Utils.instance.toastMessage(responseData["msg"]);
        }
        return null;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      print(e);
      return null;
    } finally {
      setLoading(false);
      // notifyListeners();
    }
  }

  Future<Booking?> createBooking({
    required String bookingDate,
    required String bookingTime,
  }) async {
    setLoading(true);
    String? token = await Storetoken.getToken();

    try {
      final response = await http.post(
        Uri.parse(url2 + 'create-booking/1/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "booking_date": bookingDate,
          "booking_time": bookingTime,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.instance.toastMessage(responseData['msg']);

        return Booking.fromJson(responseData['data']);
      } else {
        Utils.instance.toastMessage(responseData['msg'] ?? "Booking failed");
        return null;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: $e");
      return null;
    } finally {
      setLoading(false);
    }
  }

  Future<List<dynamic>?> ownerGetAllBookings() async {
    setLoading(true);

    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url2 + "owner-get-all-bookings/"),
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
      print(e);
      return null;
    } finally {
      setLoading(false);
      // notifyListeners();
    }
  }

  Future<List<dynamic>?> customerGetAllBookings() async {
    setLoading(true);

    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url2 + "customer-get-all-bookings/"),
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
      print(e);
      return null;
    } finally {
      setLoading(false);
      // notifyListeners();
    }
  }

  Future<Map<String, dynamic>?> getspecificSalonClient(int id) async {
    String? token = await Storetoken.getToken();
    setLoading(true);
    try {
      final response = await http.get(
        Uri.parse(url1 + 'viewservice/${id}/'),
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
        print(response.body);
        return null;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      print(e);
      return null;
    } finally {
      setLoading(false);
    }
  }

  Future<List<dynamic>?> viewservicesofspecificSalonClient(int id) async {
    String? token = await Storetoken.getToken();

    setLoading(true);
    try {
      final response = await http.get(
        Uri.parse(url1 + 'salon/${id}/allservices/'),
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
          Utils.instance.toastMessage(responseData["errors"]);
          print(response.body);
        }
        return null;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      print(e);
      return null;
    } finally {
      setLoading(false);
      // notifyListeners();
    }
  }

  Future<Map<String, dynamic>?> viewpecificerviceCleint(int id) async {
    String? token = await Storetoken.getToken();
    setLoading(true);
    try {
      final response = await http.get(
        Uri.parse(url1 + 'viewservice/${id}/'),
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
        print(response.body);
        return null;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      print(e);
      return null;
    } finally {
      setLoading(false);
    }
  }
}
