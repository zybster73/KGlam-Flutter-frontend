import 'dart:convert';

import 'package:KGlam/Services/Base_Urls.dart';
import 'package:KGlam/Services/storeToken.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/models/Booking.dart';
import 'package:KGlam/models/BookingResponse.dart';
import 'package:KGlam/models/bookingStatus.dart';
import 'package:KGlam/models/getBookings.dart';
import 'package:KGlam/models/response.dart';
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

  Future<List<dynamic>?> viewSalons(int pageNumber) async {
    setLoading(true);

    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url1 + "viewsalons/?page=${pageNumber}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //  Utils.instance.toastMessage(responseData["msg"]);
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

  Future<Response> createBooking({
    required String bookingDate,
    String? bookingTime,
    required int id,
  }) async {
    setLoading(true);
    String? token = await Storetoken.getToken();

    try {
      final response = await http.post(
        Uri.parse(url2 + 'create-booking/$id/'),
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
        print(response.body);

        return Response(
          success: true,
          message: responseData['msg'],
          booking: Booking.fromJson(responseData['data']),
        );
      } else {
        return Response(
          success: false,
          message: responseData['msg'] ?? "Booking failed",
        );
      }
    } catch (e) {
      return Response(success: false, message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<List<dynamic>?> ownerGetAllBookings(int? pageNumber) async {
    setLoading(true);

    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url2 + "owner-get-all-bookings/?page=${pageNumber}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        //Utils.instance.toastMessage(responseData["msg"]);
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

  Future<List<dynamic>?> customerGetAllBookings(int pageNumber) async {
    setLoading(true);

    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url2 + "customer-get-all-bookings/?page=${pageNumber}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Utils.instance.toastMessage(responseData["msg"]);
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

  Future<Response> ownerAcceptOrReject(String status, int id) async {
    String? token = await Storetoken.getToken();
    setLoading(true);

    try {
      final response = await http.patch(
        Uri.parse(url2 + 'booking-status/$id/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'status': status}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.instance.toastMessage(responseData['msg']);
        print(response.body);

        return Response(success: true, message: responseData['msg']);
      } else {
        return Response(
          success: false,
          message: responseData['msg'] ?? "Accept failed",
        );
      }
    } catch (e) {
      return Response(success: false, message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>?> getspecificSalonClient(int id) async {
    String? token = await Storetoken.getToken();
    setLoading(true);
    try {
      final response = await http.get(
        Uri.parse(url1 + 'salon/${id}/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
       // Utils.instance.toastMessage(responseData["msg"]);
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
       // Utils.instance.toastMessage(responseData["msg"]);
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
        // Utils.instance.toastMessage(responseData["msg"]);
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

  Future<Bookingresponse> ownerCompleteBooking(
    int bookingId,
    String status,
  ) async {
    setLoading(true);
    String? token = await Storetoken.getToken();

    try {
      final response = await http.patch(
        Uri.parse(url2 + 'owner-booking/$bookingId/complete/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'status': status}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        Utils.instance.toastMessage(data["msg"]);
        return Bookingresponse(success: true, message: data['msg'], data: data);
      } else {
        return Bookingresponse(
          success: false,
          message: data['msg'] ?? 'Something went wrong',
        );
      }
    } catch (e) {
      return Bookingresponse(success: false, message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<List<dynamic>?> ownerNotifications() async {
    setLoading(true);
    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url2 + 'owner-booking-notif/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        //Utils.instance.toastMessage(responseData["msg"]);
        print(response.body);
        print(responseData['data']);
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
    }
  }

  Future<List<dynamic>?> customerNotifications() async {
    setLoading(true);
    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url2 + 'customer-booking-notif/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Utils.instance.toastMessage(responseData["msg"]);
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
    }
  }

  Future<List<dynamic>?> ownerSeefeedback() async {
    setLoading(true);

    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url2 + 'owner-see-feedback/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Utils.instance.toastMessage(responseData["msg"]);
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
    }
  }

  Future<Map<String, dynamic>> customerGivefeedback(
    int rating,
    String fback,
    int bookingId,
  ) async {
    setLoading(true);
    String? token = await Storetoken.getToken();

    try {
      final response = await http.post(
        Uri.parse(url2 + "customer-booking/$bookingId/feedback/"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'rating': rating, 'feedback_text': fback}),
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(responseData["msg"]);
        Utils.instance.toastMessage(responseData["msg"]);
        print(response.body);
        return {'success': true, 'data': responseData['data']};
      } else {
        Utils.instance.toastMessage('feedback already submitted');
        print(responseData["msg"]);
       // Utils.instance.toastMessage(responseData['msg']);
        return {'success': false};
      }
    } catch (e) {
      Utils.instance.toastMessage(e.toString());
      return {'success': false};
    } finally {
      setLoading(false);
    }
  }

  Future<List<dynamic>?> getTopSalons() async {
    setLoading(true);

    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url1 + "top-salons/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //  Utils.instance.toastMessage(responseData["msg"]);
        print(response.body);
        return responseData['data'];
      } else {
        if (responseData["msg"] != null) {
          //  Utils.instance.toastMessage(responseData["msg"]);
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

  Future<List<dynamic>?> getTopServices() async {
    setLoading(true);

    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url1 + "top-services/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Utils.instance.toastMessage(responseData["msg"]);
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

  Future<Map<String, dynamic>> customerSeefeedback(int id) async {
    setLoading(true);

    String? token = await Storetoken.getToken();

    try {
      final response = await http.get(
        Uri.parse(url2 + 'customer-see-feedback/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Utils.instance.toastMessage(responseData["msg"]);
        print(response.body);
        return {'success': true, 'data': responseData['data']};
      } else {
        Utils.instance.toastMessage(responseData['msg']);
        return {'success': false};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      print(e);
      return {'success': false};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> markallnotificationasRead() async {
    setLoading(true);

    String? token = await Storetoken.getToken();
    try {
      final response = await http.patch(
        Uri.parse(url2 + 'notif-read-all/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Utils.instance.toastMessage(responseData["msg"]);
        print(response.body);
        return {'success': true, 'data': responseData['data']};
      } else {
        Utils.instance.toastMessage(responseData['msg']);
        return {'success': false};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      print(e);
      return {'success': false};
    } finally {
      setLoading(false);
    }
  }

  Future<List<dynamic>?> ownerBookingSearch(String query) async {
    String? token = await Storetoken.getToken();

    setLoading(true);
    try {
      final response = await http.get(
        Uri.parse(url2 + 'owner-booking-search/?q=$query'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
       // Utils.instance.toastMessage(responseData["msg"]);
        print(response.body);
        return responseData['data'];
      } else {
        if (responseData["msg"] != null) {
          Utils.instance.toastMessage(responseData["msg"]);
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
    }
  }

  Future<List<dynamic>?> customerBookingSearch(String query) async {
    String? token = await Storetoken.getToken();

    setLoading(true);
    try {
      final response = await http.get(
        Uri.parse(url2 + 'customer-booking-search/?q=$query'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
       // Utils.instance.toastMessage(responseData["msg"]);
        print(response.body);
        return responseData['data'];
      } else {
        if (responseData["msg"] != null) {
          Utils.instance.toastMessage(responseData["msg"]);
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
    }
  }


 Future<List<dynamic>?> searchSalon(String query) async {
    String? token = await Storetoken.getToken();

    setLoading(true);
    try {
      final response = await http.get(
        Uri.parse(url1 + 'salon/search/?q=$query'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200 ) {
       // Utils.instance.toastMessage(responseData["msg"]);
        print(response.body);
        return responseData['data'];
      } else {
        if (responseData["msg"] != null) {
          Utils.instance.toastMessage(responseData["msg"]);
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
    }
  }
  
}
