import 'package:flutter/material.dart';

class UnFollowingUsersScreen extends StatelessWidget {
  const UnFollowingUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15, // Replace with actual chat count
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            // Replace with actual user image or initials
            child: Text('YM'),
          ),
          title: Text('Yasser mohamud'),
          onTap: () {
            // Navigate to chat details screen
          },
          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle follow button press
            },
          ),
        );
      },
    );
  }
}
