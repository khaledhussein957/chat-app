import 'package:flutter/material.dart';

class UserChat extends StatelessWidget {
  const UserChat({super.key});

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
          subtitle: Text('Hello'),
          onTap: () {
            // Navigate to chat details screen
          },
          trailing: Text('4:00 PM'),
        );
      },
    );
  }
}
