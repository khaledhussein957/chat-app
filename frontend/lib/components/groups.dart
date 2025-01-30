import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:frontend/pages/groupMessaging_screen.dart';

class Groups extends StatelessWidget {
  const Groups({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.just.edu.so/assets/images/black.png'),
              child: Text('YM'),
            ),
            title: Text('CA212'),
            subtitle: Text('Berito fasax wye.'),
            onTap: () => Get.to(GroupMessagingScreen()),
            trailing: Text('4:10 PM'),
          );
        });
  }
}
