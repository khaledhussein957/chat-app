import 'package:flutter/material.dart';

class FollowingUsersScreen extends StatelessWidget {
  const FollowingUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15, // Replace with actual chat count
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage('https://www.just.edu.so/assets/images/black.png'),
            child: Text('YM'),
          ),
          title: Text('Yasser mohamud'),
          onTap: () {
            // Navigate to chat details screen
          },
          trailing: IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              // Handle follow button press
            },
          ),
        );
      },
    );
  }
}
