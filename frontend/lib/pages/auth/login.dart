import 'package:flutter/material.dart';
import 'package:frontend/controller/authController/login_controller.dart';
import 'package:frontend/pages/auth/signup.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  controller: LoginController().emailController,
                  decoration: InputDecoration(labelText: 'Enter your email'),
                ),
                SizedBox(
                  height: 17.48,
                ),
                TextField(
                  controller: LoginController().passwordController,
                  decoration: InputDecoration(labelText: 'Enter your password'),
                ),
                SizedBox(
                  height: 34.48,
                ),
                ElevatedButton(
                  onPressed: () => LoginController().login(),
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(245, 36.52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
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
