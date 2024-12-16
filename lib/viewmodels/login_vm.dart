import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginVm extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isUsernameValid = true.obs;
  var isPasswordValid = true.obs;
  var errorMessage = ''.obs;
  var isPasswordVisible = false.obs;

  /// Method to validate and perform login
  Future<void> login() async {
    isUsernameValid.value = _isValidEmail(username.value);
    isPasswordValid.value = password.value.length >= 6;

    if (!isUsernameValid.value || !isPasswordValid.value) {
      errorMessage.value = 'Invalid credentials';
      return;
    }

    /// Load saved credentials from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');
    final savedPassword = prefs.getString('password');

    /// Check if the entered credentials match saved ones
    if (username.value == savedUsername && password.value == savedPassword) {
      errorMessage.value = '';
      Fluttertoast.showToast(
        msg: "Login success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Get.offNamed('/home');
    } else {
      errorMessage.value = 'Invalid credentials';
      Fluttertoast.showToast(
        msg: "Invalid credentials",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  /// Method to validate if the username is a valid email
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  /// Save Entered Credential
  Future<void> saveCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }
}
