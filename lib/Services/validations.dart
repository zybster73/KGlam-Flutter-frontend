import 'package:flutter/material.dart';

class Validations with ChangeNotifier {
  String? passwordError;
   String? emailError;
    String? confirmPasswordError;

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError = "Password cannot be empty";
    } else if (value.length < 8) {
      passwordError = "Password must be at least 8 characters";
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      passwordError = "Add at least one uppercase letter";
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      passwordError = "Add at least one number";
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      passwordError = "Add at least one lowercase letter";
    } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      passwordError = "Add at least one special character";
    } else {
      passwordError = null;
    }
    notifyListeners();
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError = "Email cannot be empty";
    } else if (!RegExp(
            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      emailError = "Enter a valid email address";
    } else {
      emailError = null;
    }
    notifyListeners();
  }

   void validateConfirmPassword({
    required String password,
    required String confirmPassword,
  }) {
    if (confirmPassword.isEmpty) {
      confirmPasswordError = "Confirm password cannot be empty";
    } else if (password != confirmPassword) {
      confirmPasswordError = "Passwords do not match";
    } else {
      confirmPasswordError = null;
    }
    notifyListeners();
  }
}
