// ignore_for_file: file_names

import 'dart:convert';
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
      return null;
    } finally {
      setLoading(false);
      // notifyListeners();
    }
  }

  Future<bool> updateUserDetails({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
    required String phoneNumber,
    File? profileImage, // OPTIONAL IMAGE
  }) async {
    String? token = await Storetoken.getToken();
    setLoading(true);

    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(url + "updateinfo/"),
      );

      // Headers
      request.headers['Authorization'] = 'Bearer $token';

      // Text fields
      request.fields['old_password'] = oldPassword;
      request.fields['new_password'] = newPassword;
      request.fields['confirm_password'] = confirmPassword;
      request.fields['contact_number'] = phoneNumber;

      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profile_image', profileImage.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.instance.toastMessage('Saved changes');
        return true;
      } else {
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          Utils.instance.toastMessage(responseData['errors'][firstField][0]);
        } else if (responseData['msg'] != null) {
          Utils.instance.toastMessage(responseData['msg']);
        }
        return false;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> salonInformation(
    String salon_name,
    String salonAddress,
    String salonContact,
    String hours,
    String salonDesc,
    File? profileImage,
    File? coverImage,
  ) async {
    setLoading(true);
    String? token = await Storetoken.getToken();

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url1 + 'createsalon/'),
      );

      request.headers.addAll({"Authorization": "Bearer $token"});

      // Text fields
      request.fields.addAll({
        'salon_name': salon_name,
        'salon_address': salonAddress,
        'salon_contact': salonContact,
        'hours_of_operation': hours,
        'salon_desc': salonDesc,
      });

      // Profile image
      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'salon_profile_image',
            profileImage.path,
          ),
        );
      }

      // Cover / second image
      if (coverImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'salon_cover_image',
            coverImage.path,
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Response body: ${response.body}");

      var responseData = jsonDecode(response.body);

      var salonId = responseData['data']?['id'];
      if (salonId != null) {
        await Storetoken.saveSalonId(salonId);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.instance.toastMessage(responseData['msg']);
        return {
          'success': true,
          'message': responseData['msg'],
          'data': responseData['data'],
        };
      } else {
        String errorMsg = responseData['msg'] ?? 'Something went wrong';
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          errorMsg = responseData['errors'][firstField][0];
        }
        Utils.instance.toastMessage(errorMsg);
        return {'success': false, 'message': errorMsg};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> serviceInformation(
    String serviceName,
    String servicePrice,
    String serviceDuration,
    String serviceDesc,
    File? serviceImage,
  ) async {
    setLoading(true);
    String? token = await Storetoken.getToken();
    int? id = await Storetoken.getSalonId();

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url1 + "salon/${id}/service/create/"),
      );

      request.headers.addAll({"Authorization": "Bearer $token"});

      // Text fields
      request.fields.addAll({
        'service_name': serviceName,
        'service_price': servicePrice,
        'service_duration': serviceDuration,
        'service_desc': serviceDesc,
      });

      // Image
      if (serviceImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('service_image', serviceImage.path),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Response body: ${response.body}");

      var responseData = jsonDecode(response.body);

      var serviceID = responseData['data']?['id'];
      if (serviceID != null) {
        await Storetoken.saveServiceId(serviceID);
        print("Service id is = $serviceID");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.instance.toastMessage(responseData['msg']);
        return {
          'success': true,
          'message': responseData['msg'],
          'data': responseData['data'],
        };
      } else {
        String errorMsg = responseData['msg'] ?? 'Something went wrong';
        if (responseData['errors'] != null &&
            responseData['errors'].isNotEmpty) {
          var firstField = responseData['errors'].keys.first;
          errorMsg = responseData['errors'][firstField][0];
        }
        Utils.instance.toastMessage(errorMsg);
        return {'success': false, 'message': errorMsg};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> updateSolonDetails(
    String salon_name,
    String salonAddress,
    String salonContact,
    String hours,
    String salonDesc,
    File? profileImage,
    File? coverImage,
  ) async {
    setLoading(true);
    String? token = await Storetoken.getToken();

    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(url1 + 'updatesalon/'),
      );

      request.headers.addAll({"Authorization": "Bearer $token"});

      request.fields.addAll({
        'salon_name': salon_name,
        'salon_address': salonAddress,
        'salon_contact': salonContact,
        'hours_of_operation': hours,
        'salon_desc': salonDesc,
      });

      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'salon_profile_image',
            profileImage.path,
          ),
        );
      }

      if (coverImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'salon_cover_image',
            coverImage.path,
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.instance.toastMessage(responseData['msg']);
        return {
          'success': true,
          'message': responseData['msg'],
          'data': responseData['data'],
        };
      } else {
        Utils.instance.toastMessage(responseData['msg']);
        return {'success': false, 'message': responseData['msg']};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> updateService(
    int serviceId,
    String serviceName,
    String servicePrice,
    String serviceDuration,
    String serviceDesc,
    File? serviceImage,
  ) async {
    setLoading(true);
    String? token = await Storetoken.getToken();

    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(url1 + 'updateservice/$serviceId/'),
      );

      request.headers.addAll({"Authorization": "Bearer $token"});

      request.fields.addAll({
        'service_name': serviceName,
        'service_price': servicePrice,
        'service_duration': serviceDuration,
        'service_desc': serviceDesc,
      });

      if (serviceImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('service_image', serviceImage.path),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.instance.toastMessage('Service updated successfully');
        return {
          'success': true,
          'message': responseData['msg'],
          'data': responseData['data'],
        };
      } else {
        Utils.instance.toastMessage(responseData['msg']);
        return {'success': false, 'message': responseData['msg']};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }

  Future<List<dynamic>?> viewservicesofspecificSalon() async {
    String? token = await Storetoken.getToken();
    int? id = await Storetoken.getSalonId();
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

  Future<Map<String, dynamic>?> getspecificSalon() async {
    String? token = await Storetoken.getToken();
    int? id = await Storetoken.getSalonId();
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

      if (response.statusCode == 200 || response.statusCode == 200) {
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

  Future<Map<String, dynamic>> createPortfolio(
    String serviceName,
    String description,
    File? imageFile,
  ) async {
    setLoading(true);
    String? token = await Storetoken.getToken();

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url1 + "create/portfolio/"),
      );

      request.headers['Authorization'] = "Bearer $token";

      request.fields['item_name'] = serviceName;
      request.fields['description'] = description;

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.instance.toastMessage('Portfolio created successfully');
        print(response.body);
        return {'success': true, 'data': responseData['data']};
      } else {
        Utils.instance.toastMessage(responseData['msg']);
        return {'success': false};
      }
    } catch (e) {
      Utils.instance.toastMessage(e.toString());
      return {'success': false};
    } finally {
      setLoading(false);
    }
  }

  Future<List<dynamic>?> viewPortfolio() async {
    String? token = await Storetoken.getToken();

    setLoading(true);
    try {
      final response = await http.get(
        Uri.parse(url1 + 'view/portfolio/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        //Utils.instance.toastMessage('Loading.....');
        print(response.body);
        return responseData['data'];
      } else {
        Utils.instance.toastMessage("Failed to fetch portfolio");
        return null;
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: ${e.toString()}");

      return null;
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> updatePortfolio(
    int portfolioId,
    String serviceName,
    String description,
    File? imageFile,
  ) async {
    setLoading(true);
    String? token = await Storetoken.getToken();
    int? id = await Storetoken.getPortfolioId();

    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(url1 + "update/portfolio/$portfolioId/"),
      );

      request.headers['Authorization'] = "Bearer $token";

      request.fields['item_name'] = serviceName;
      request.fields['description'] = description;

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.instance.toastMessage("Portfolio updated successfully");
        return {'success': true, 'data': responseData['data']};
      } else {
        Utils.instance.toastMessage(responseData['msg']);
        return {'success': false};
      }
    } catch (e) {
      Utils.instance.toastMessage(e.toString());
      return {'success': false};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> deletePortfolio(int portfolioId) async {
    String? token = await Storetoken.getToken();

    setLoading(true);
    try {
      final response = await http.delete(
        Uri.parse('${url1}delete/portfolio/$portfolioId/'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        Utils.instance.toastMessage("Portfolio deleted successfully");
        return {'success': true, 'message': 'Deleted successfully'};
      } else {
        Utils.instance.toastMessage(responseData['msg'] ?? 'Delete failed');
        return {'success': false, 'message': responseData['msg'] ?? 'Error'};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: $e");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }

  Future<Map<String, dynamic>> deleteService(int serviceId) async {
    String? token = await Storetoken.getToken();

    setLoading(true);
    try {
      final response = await http.delete(
        Uri.parse('${url1}deleteservice/$serviceId/'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        Utils.instance.toastMessage("Service deleted successfully");
        return {'success': true, 'message': 'Deleted successfully'};
      } else {
        Utils.instance.toastMessage(responseData['msg'] ?? 'Delete failed');
        return {'success': false, 'message': responseData['msg'] ?? 'Error'};
      }
    } catch (e) {
      Utils.instance.toastMessage("Error: $e");
      return {'success': false, 'message': e.toString()};
    } finally {
      setLoading(false);
    }
  }
}
