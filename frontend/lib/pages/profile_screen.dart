import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/services/user_services.dart';
import 'package:get/get.dart';

import 'package:frontend/pages/chat_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // disallowing the back button
        automaticallyImplyLeading: false,
        title: Text('Profile'),
      ),
      body: Obx(() {
        if (!userController.isLoggedIn.value) {
          Get.to(LoginScreen());
        }

        // ignore: invalid_use_of_protected_member
        var user = userController.user.value;

        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user['image'] ??
                  'https://www.just.edu.so/assets/images/black.png'),
            ),
            SizedBox(height: 28),
            Text(
              user['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 9),
            Text(user['bio']),
            SizedBox(height: 9),
            Text(user['email']),
            SizedBox(height: 24),
            // ElevatedButton(
            //   // width: 245, height: 36.52,
            //   style: ElevatedButton.styleFrom(
            //       minimumSize: Size(245, 36.52),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(5),
            //       )),
            //   onPressed: () => Get.to(UpdateProfileInfoScreen()),
            //   child: Text('Edit Profile'),
            // ),
            // SizedBox(height: 10.48),
            // ElevatedButton(
            //   // width: 245, height: 36.52,
            //   style: ElevatedButton.styleFrom(
            //       minimumSize: Size(245, 36.52),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(5),
            //       )),
            //   onPressed: () => Get.to(ConfirmDialog(
            //       title: 'Are you sure?',
            //       content: 'Do you want to delete your account?',
            //       onConfirm: () => print('Account deleted'),
            //       onCancel: () => Get.back())),
            //   child: Text('Delete Account'),
            // ),
          ],
        ));
      }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () => Get.to(ChatScreen()),
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Get.to(ProfileScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
