// import 'package:flutter/material.dart';
// import 'package:frontend/services/user_services.dart';
// import 'package:get/get.dart';

// class Users extends StatelessWidget {
//   final UserController userController = Get.put(UserController());

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: userController.users.length,
//       itemBuilder: (context, index) {
//         var user = userController.users[index];
//         return Card(
//           margin: EdgeInsets.all(10),
//           child: ListTile(
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(user.imageUrl),
//             ),
//             title: Text(user.name),
//             subtitle: user.followed
//                 ? Text('Followed', style: TextStyle(color: Colors.green))
//                 : Text('Not Followed', style: TextStyle(color: Colors.red)),
//             trailing: IconButton(
//               icon: Icon(
//                 user.followed ? Icons.person_remove : Icons.person_add,
//                 color: user.followed ? Colors.red : Colors.blue,
//               ),
//               onPressed: () {
//                 if (user.followed) {
//                   userController.unfollowUser(user);
//                 } else {
//                   userController.followUser(user);
//                 }
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
