import 'package:flutter/material.dart';
import 'package:frontend/controller/authController/signup_controller.dart';
import 'package:frontend/pages/auth/login.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupController signupController = Get.put(SignupController());

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
                  'Signup',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 65,
                ),
                TextField(
                  controller: signupController.nameController,
                  decoration: InputDecoration(labelText: 'Enter your name'),
                ),
                SizedBox(
                  height: 17.48,
                ),
                TextField(
                  controller: signupController.emailController,
                  decoration: InputDecoration(labelText: 'Enter your email'),
                ),
                SizedBox(
                  height: 17.48,
                ),
                TextField(
                  controller: signupController.passwordController,
                  decoration: InputDecoration(labelText: 'Enter your password'),
                ),
                SizedBox(
                  height: 34.48,
                ),
                ElevatedButton(
                  onPressed: () => signupController.signup(),
                  child: Text('Signup'),
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
                  onPressed: () => Get.to(LoginScreen()),
                  child: Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
