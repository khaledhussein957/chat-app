import 'package:flutter/material.dart';
import 'package:frontend/pages/chat_room.dart';
import 'package:frontend/services/user_services.dart';
import 'package:get/get.dart';

class UserChat extends StatelessWidget {
  UserController chatController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatController.users.length,
      itemBuilder: (context, index) {
        var user = chatController.users[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.imageUrl),
            ),
            title: Text(user.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.lastMessage ?? "No messages yet"),
                Text(
                  user.lastMessage ?? "",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            onTap: () {
              // Navigate to chat screen for the selected user.
              Get.to(() => ChatRoomScreen(user: user));
            },
          ),
        );
      },
    );
  }
}
