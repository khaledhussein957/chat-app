// import 'package:flutter/material.dart';
// import 'package:frontend/pages/login.dart';
// import 'package:frontend/services/user_services.dart';
// import 'package:get/get.dart';

// import 'package:frontend/components/users.dart';
// import 'package:frontend/pages/chat_screen.dart';
// import 'package:frontend/pages/profile_screen.dart';
// import 'package:frontend/pages/status_screen.dart';

// class UsersScreen extends StatelessWidget {
//   final UserController userController = Get.put(UserController());

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           // disallowing the back button
//           automaticallyImplyLeading: false,
//           title: Text('Users'),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'All Users'),
//               Tab(text: 'Friends'),
//             ],
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 // Handle search button press
//               },
//             ),
//           ],
//         ),
//         body: Obx(() {
//           if (!userController.isLoggedIn.value) {
//             Get.to(LoginScreen());
//             return SizedBox.shrink(); // Return an empty widget
//           } else if (userController.users.isEmpty) {
//             return Center(child: Text('No users found.'));
//           } else {
//             Get.to(Users());
//             return SizedBox.shrink(); // Return an empty widget
//           }
//         }),
//         bottomNavigationBar: BottomAppBar(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.chat),
//                 onPressed: () => Get.to(ChatScreen()),
//               ),
//               IconButton(
//                 icon: Icon(Icons.people),
//                 onPressed: () => Get.to(UsersScreen()),
//               ),
//               // status icon
//               IconButton(
//                 icon: Icon(Icons.camera),
//                 onPressed: () => Get.to(StatusScreen()),
//               ),
//               IconButton(
//                 icon: Icon(Icons.person),
//                 onPressed: () => Get.to(ProfileScreen()),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
