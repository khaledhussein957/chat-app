import 'package:flutter/material.dart';
import 'package:frontend/pages/chat/chats.dart';
import 'package:frontend/pages/status/statusscreen.dart';
import 'package:frontend/pages/user/users.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // disallowing the back button
        automaticallyImplyLeading: false,
        title: Text('Profile'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlyrbjd4Gl58ViAa1bgouw0ECgDGxCaBaJPg&s'),
          ),
          SizedBox(height: 28),
          Text(
            'Mohamed Ahmed Mohamud',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 9),
          Text('MERN Stack Developer'),
          SizedBox(height: 9),
          Text('mohamedahmedmohamud@gmail.com'),
          SizedBox(height: 24),
          ElevatedButton(
            // width: 245, height: 36.52,
            style: ElevatedButton.styleFrom(
                minimumSize: Size(245, 36.52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
            onPressed: () {
              // Handle Edit Profile button press
            },
            child: Text('Edit Profile'),
          ),
          SizedBox(height: 10.48),
          ElevatedButton(
            // width: 245, height: 36.52,
            style: ElevatedButton.styleFrom(
                minimumSize: Size(245, 36.52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
            onPressed: () {
              // Handle Delete button press
            },
            child: Text('Delete Account'),
          ),
        ],
      )),
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
                onPressed: () => Get.to(StatusScreen())),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Handle profile button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
