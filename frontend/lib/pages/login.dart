import 'package:flutter/material.dart';
import 'package:frontend/pages/chat_screen.dart';
import 'package:frontend/pages/signup.dart';
import 'package:frontend/services/user_services.dart';

import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 86,
                ),
                Text(
                  'Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 65,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Enter your email'),
                ),
                SizedBox(
                  height: 17.48,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Enter your password'),
                ),
                SizedBox(
                  height: 34.48,
                ),
                Obx(() {
                  if (userController.isLoggedIn.value) {
                    Get.to(ChatScreen());
                  }
                  return ElevatedButton(
                    onPressed: () {
                      userController.login(
                        emailController.text.trim(),
                        passwordController.text,
                      );

                      Get.to(ChatScreen());
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(245, 36.52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  );
                }),
                SizedBox(
                  height: 17.48,
                ),
                TextButton(
                  onPressed: () => Get.to(SignupScreen()),
                  child: Text('Don\'t have an account? Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
