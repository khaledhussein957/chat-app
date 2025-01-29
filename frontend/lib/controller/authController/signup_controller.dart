import 'package:flutter/material.dart';
import 'package:frontend/pages/chat/chats.dart';
import 'package:frontend/utils/api_endpoint.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> signup() async {
    try {
      Map<String, String> body = {
        "name": nameController.text,
        "email": emailController.text.trim(),
        "password": passwordController.text,
      };

      var url = Uri.parse(
        APIENDPOINTS.baseUrl + APIENDPOINTS.authEndpoints.signupAuth,
      );

      var headers = {'Content-Type': 'application/json'};

      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        if (data['success'] == true) {
          var token = data['data']['token'] ?? '';
          print(token);

          // final SharedPreferences prefs = await _prefs;
          // await prefs.setString('token', token);

          nameController.clear();
          emailController.clear();
          passwordController.clear();
          Get.snackbar('Success', 'Signup successful');

          // navigate to Home page
          Get.off(ChatScreen());
        } else if (data['success'] == false) {
          Get.snackbar('Error', data['message']);
        }
      } else {
        // Handle error response
        print('Signup failed: ${response.body}');
        Get.snackbar('Error', 'Signup failed');
      }
    } catch (error) {
      print('Error in signup: $error');
      Get.snackbar('Error', 'An error occurred during signup');
    }
  }
}
