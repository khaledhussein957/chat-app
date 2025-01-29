import 'package:flutter/material.dart';
import 'package:frontend/components/groups.dart';
import 'package:frontend/components/userChat.dart';
import 'package:frontend/pages/status/statusscreen.dart';
import 'package:frontend/pages/user/profile.dart';
import 'package:frontend/pages/user/users.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            PopupMenuButton(
              icon: Icon(Icons.menu),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text('Create Group'),
                    onTap: () {
                      // pop up dialog for create group
                    },
                  ),
                  PopupMenuItem(
                    child: Text('Logout'),
                    onTap: () {
                      // Handle logout button press
                    },
                  ),
                ];
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Chats'),
              Tab(text: 'Groups'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First tab content
            UserChat(),
            // Second tab content (Following users)
            Groups(),
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
                onPressed: () => Get.to(UsersScreen()),
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
