import 'package:flutter/material.dart';
import 'package:frontend/pages/chat_screen.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/services/user_services.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
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
                SizedBox(height: 86),
                Text(
                  'Signup',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 65),

                // Name Input
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Enter your name'),
                ),
                SizedBox(height: 17.48),

                // Email Input with validation
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Enter your email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 17.48),

                // Password Input
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Enter your password'),
                ),
                SizedBox(height: 34.48),

                // Observing loading state and user signup
                Obx(() {
                  if (userController.isLoggedIn.value) {
                    Get.to(
                        ChatScreen()); // Show a loading spinner while signup is in progress
                  }

                  if (userController.isLoggedIn.value) {
                    Get.to(ChatScreen());
                  }

                  return ElevatedButton(
                    onPressed: () {
                      String name = nameController.text;
                      String email = emailController.text.trim();
                      String password = passwordController.text;

                      // Basic field validation
                      if (name.isEmpty || email.isEmpty || password.isEmpty) {
                        Get.snackbar('Error', 'Please fill all the fields');
                        return;
                      }

                      // Email format validation
                      if (!GetUtils.isEmail(email)) {
                        Get.snackbar('Error', 'Please enter a valid email');
                        return;
                      }

                      userController.signup(name, email, password);
                      Get.to(ChatScreen());
                    },
                    child: Text('Sign Up'),
                  );
                }),

                SizedBox(height: 17.48),

                // Redirect to Login Screen
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
