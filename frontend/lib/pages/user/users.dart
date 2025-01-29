import 'package:flutter/material.dart';
import 'package:frontend/pages/chat/chats.dart';
import 'package:frontend/pages/status/statusscreen.dart';
import 'package:frontend/components/followingUsers.dart';
import 'package:frontend/components/unFollowingUsers.dart';
import 'package:frontend/pages/user/profile.dart';
import 'package:get/get.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          // disallowing the back button
          automaticallyImplyLeading: false,
          title: Text('Users'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'All Users'),
              Tab(text: 'Friends'),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Handle search button press
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // First tab content
            UnFollowingUsersScreen(),
            // Second tab content (Following users)
            FollowingUsersScreen(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.chat),
                onPressed: () => Get.to(ChatScreen()),
              ),
              IconButton(
                icon: Icon(Icons.people),
                onPressed: () {
                  // Handle group chat button press
                },
              ),
              // status icon
              IconButton(
                icon: Icon(Icons.camera),
                onPressed: () => Get.to(StatusScreen()),
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () => Get.to(ProfileScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
