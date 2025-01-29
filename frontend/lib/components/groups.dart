import 'package:flutter/material.dart';

class Groups extends StatelessWidget {
  const Groups({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              // Replace with actual user image or initials
              child: Text('YM'),
            ),
            title: Text('CA212'),
            subtitle: Text('Berito fasax wye.'),
            onTap: () {
              // Navigate to chat details screen
            },
            trailing: Text('4:10 PM'),
          );
        });
  }
}
