import 'dart:convert';
import 'package:KGlam/Services/Base_Urls.dart';
import 'package:KGlam/Services/storeToken.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Notificationservices with ChangeNotifier {
  final url = BaseUrls.baseUrl;
  bool isLoading = false;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void requestNotificationPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      carPlay: true,
      announcement: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User denied permission');
    }
  }

  Future<String?> getFcmToken() async {
    try {
      return await messaging.getToken();
    } catch (e) {
      print("Error getting FCM token: $e");
      return null;
    }
  }

  void listenToTokenRefresh() {
    messaging.onTokenRefresh.listen((newToken) async {
      print("FCM token refreshed: $newToken");
      if (newToken.isNotEmpty) {
        await sendTokenToBackend(newToken);
        print('refresh token sent');
      }
    });
  }

  Future<void> sendTokenToBackend(String fcmToken) async {
    setLoading(true);
    String? token = await Storetoken.getToken();

    if (token == null) {
      print("User not logged in, cannot send FCM token");
      setLoading(false);
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url + "device-register-fcm/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'registration_id': fcmToken, 'platform': 'android'}),
      );

      if (response.statusCode == 200) {
        print("Device registered successfully");
      } else {
        print("Failed to register device: ${response.body}");
      }
    } catch (e) {
      print("Error sending token to backend: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> tokensentAfterLogin() async {
    print("tokensentAfterLogin called");
    final fcmToken = await getFcmToken();
    print("Fetched FCM token: $fcmToken");
    if (fcmToken != null && fcmToken.isNotEmpty) {
      await sendTokenToBackend(fcmToken);
      print('token sent');
    }
  }
}
