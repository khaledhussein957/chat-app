import 'package:flutter/material.dart';
import 'package:frontend/components/user.dart';
import 'package:frontend/pages/chat_room.dart';
import 'package:frontend/services/user_services.dart';
import 'package:get/get.dart';

import 'package:frontend/pages/profile_screen.dart';
import 'package:frontend/pages/login.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  // If you want to manage something specific in ChatScreen, like user data or auth state, you can use a controller (e.g., AuthController)
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    userController.getUsers();

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          // disallowing the back button
          automaticallyImplyLeading: false,
          title: Text('Chats'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Navigate to a search screen
                Get.toNamed('/search');
              },
            ),
            PopupMenuButton(
              icon: Icon(Icons.menu),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text('Logout'),
                    onTap: () {
                      // Handle logout with GetX
                      // userController.logout();
                      Get.to(LoginScreen());
                    },
                  ),
                ];
              },
            ),
          ],
        ),
        body: Obx(() {
          if (!userController.isLoggedIn.value) {
            // spinner
            return Center(child: CircularProgressIndicator());
          } else if (userController.users.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            return ListView.builder(
              itemCount: userController.users.length,
              itemBuilder: (context, index) {
                var user = userController.users[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    onTap: () {
                      // Handle user tap (navigate to a detail screen, etc.)
                      Get.to(() => ChatRoomScreen(user: user));
                    },
                  ),
                );
              },
            );
          }
        }),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Navigation buttons using GetX
              IconButton(
                icon: Icon(Icons.chat),
                onPressed: () => Get.toNamed('/chat'),
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () =>
                    Get.to(ProfileScreen()), // Navigate to Profile Screen
              ),
            ],
          ),
        ),
      ),
    );
  }
}
