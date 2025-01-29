import 'package:flutter/material.dart';
import 'package:frontend/pages/chat/chats.dart';
import 'package:frontend/pages/user/profile.dart';
import 'package:frontend/pages/user/users.dart';
import 'package:get/get.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // disallowing the back button
        automaticallyImplyLeading: false,
        title: Text('Status'),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        ListTile(
          leading: CircleAvatar(
            // Replace with actual user image or initials
            child: Text('YM'),
          ),
          title: Text('my status'),
          subtitle: Text('Tap to add status update'),
        ),
        // line divider
        Divider(),
        Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Recent updates',
              style: TextStyle(fontSize: 10),
            )),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            ListTile(
              leading: CircleAvatar(
                // Replace with actual user image or initials
                child: Text('YM'),
              ),
              title: Text('Yasser mohamud'),
              onTap: () {},
            ),
            ListTile(
              leading: CircleAvatar(
                // Replace with actual user image or initials
                child: Text('YM'),
              ),
              title: Text('Yasser mohamud'),
              onTap: () {},
            ),
            ListTile(
              leading: CircleAvatar(
                // Replace with actual user image or initials
                child: Text('YM'),
              ),
              title: Text('Yasser mohamud'),
              onTap: () {},
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Recent updates',
              style: TextStyle(fontSize: 10),
            )),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            ListTile(
              leading: CircleAvatar(
                // Replace with actual user image or initials
                child: Text('YM'),
              ),
              title: Text('Yasser mohamud'),
              onTap: () {},
            ),
            ListTile(
              leading: CircleAvatar(
                // Replace with actual user image or initials
                child: Text('YM'),
              ),
              title: Text('Yasser mohamud'),
              onTap: () {},
            ),
            ListTile(
              leading: CircleAvatar(
                // Replace with actual user image or initials
                child: Text('YM'),
              ),
              title: Text('Yasser mohamud'),
              onTap: () {},
            ),
          ],
        ),
      ])),
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
            IconButton(icon: Icon(Icons.camera), onPressed: () {}),
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
