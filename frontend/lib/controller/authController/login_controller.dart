import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/utils/api_endpoint.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    try {
      Map<String, String> body = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var url = Uri.parse(
        APIENDPOINTS.baseUrl + APIENDPOINTS.authEndpoints.loginAuth,
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

          emailController.clear();
          passwordController.clear();
          Get.snackbar('Success', 'Login successful');

          // navigate to Home page
          // Get.off(ChatScreen());
        } else if (data['success'] == false) {
          Get.snackbar('Error', data['message']);
        }
      } else {
        // Handle error response
        print('Login failed: ${response.body}');
        Get.snackbar('Error', 'Login failed');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Login failed');
    }
  }
}
