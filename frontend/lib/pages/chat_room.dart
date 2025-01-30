import 'package:flutter/material.dart';
import 'package:frontend/components/user.dart';
import 'package:frontend/services/user_services.dart';
import 'package:get/get.dart';

class ChatRoomScreen extends StatelessWidget {
  final User user;

  ChatRoomScreen({required this.user});

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserController chatController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${user.name}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Display last messages
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(user.lastMessage ?? "No messages yet"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: "Type a message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      // Call sendMessage method from UserController
                      chatController.sendMessageToUser(_messageController.text);
                      _messageController.clear();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
