import 'dart:convert';
import 'package:frontend/components/user.dart';
import 'package:frontend/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  var isLoggedIn = false.obs;
  var user = {}.obs; // To store the user data
  var token = ''.obs; // To store the token after login
  var users = <User>[].obs;

  // Your backend URL
  final String baseUrl =
      APIENDPOINTS.baseUrl; // Change to your backend API base URL
  // Signup method
  Future<void> signup(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + APIENDPOINTS.authEndpoints.signupAuth),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        user.value = data['user'];
        token.value = data['user']['token'];
        isLoggedIn.value = true;

        Get.snackbar('Success', data['message']);
        // Store token locally using a storage mechanism like shared preferences or secure storage
      } else {
        final data = json.decode(response.body);
        Get.snackbar('Error', data['message']);
      }
    } catch (error) {
      Get.snackbar('Error', 'Signup failed');
      print("Error in signup: $error");
    }
  }

  // Login method
  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + APIENDPOINTS.authEndpoints.loginAuth),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user.value = data['user'];
        token.value = data['user']['token'];
        isLoggedIn.value = true;

        Get.snackbar('Success', data['message']);
        // Store token locally using a storage mechanism like shared preferences or secure storage
      } else {
        final data = json.decode(response.body);
        Get.snackbar('Error', data['message']);
        throw Exception('Failed to log in: ${response.body}');
      }
    } catch (error) {
      print("Error in login: $error");
    }
  }

  // Get user profile
  Future<void> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + APIENDPOINTS.userEndpoints.profileUser),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.value}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user.value = data;
      } else {
        throw Exception('Failed to fetch profile: ${response.body}');
      }
    } catch (error) {
      print("Error in fetching profile: $error");
    }
  }

  // Update user profile
  Future<void> updateProfile(String name, String bio, XFile? image) async {
    try {
      final response = await http.put(
        Uri.parse(baseUrl + APIENDPOINTS.userEndpoints.updateProfile),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.value}',
        },
        body: json.encode({
          'name': name,
          'bio': bio,
          'image': image,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user.value = data['user'];
      } else {
        throw Exception('Failed to update profile: ${response.body}');
      }
    } catch (error) {
      print("Error in updating profile: $error");
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + APIENDPOINTS.authEndpoints.logoutAuth),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.value}',
        },
      );

      if (response.statusCode == 200) {
        user.value = {};
        token.value = '';
        isLoggedIn.value = false;
        // Clear token from local storage if needed
      } else {
        throw Exception('Failed to log out: ${response.body}');
      }
    } catch (error) {
      print("Error in logout: $error");
    }
  }

  // delete profile
  Future<void> deleteProfile() async {
    try {
      final respose = await http.delete(
        Uri.parse(baseUrl + APIENDPOINTS.userEndpoints.deleteAccount),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.value}',
        },
      );

      if (respose.statusCode == 200) {
        user.value = {};
        token.value = '';
        isLoggedIn.value = false;
        // clear token from local storage if needed
      } else {
        throw Exception('Failed to delete account: ${respose.body}');
      }
    } catch (error) {
      print("Error in delete profile: $error");
    }
  }

  // get users
  Future<void> getUsers() async {
    try {
      final response = await http.get(
          Uri.parse(baseUrl + APIENDPOINTS.userEndpoints.getUsers),
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer ${token.value}',
          });
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        users.value = data
            .map((userJson) => User.fromJson(userJson))
            .toList(); // Convert JSON to User objects
      } else {
        Get.snackbar('Error', 'Failed to fetch users');
        throw Exception('Failed to fetch users: ${response.body}');
      }
    } catch (error) {
      print("Error in get users: $error");
    }
  }

  // Follow a user
  // void followUser(User user) {
  //   user.followed = true;
  //   users.refresh(); // Refresh the list to reflect changes.
  // }

  // // Unfollow a user
  // void unfollowUser(User user) {
  //   user.followed = false;
  //   users.refresh(); // Refresh the list to reflect changes.
  // }

  // // Send a message (simulate message sending)
  // void sendMessage(User user, String message) {
  //   user.lastMessage = message;
  //   user.lastMessageTime = "Just now"; // Simulate the time.
  //   users.refresh();
  // }

  // Future<void> getUserChats() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(baseUrl + APIENDPOINTS.messageEndpoints.getMessages),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${token.value}',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       List<dynamic> data = json.decode(response.body);
  //       users.value = data.map((userJson) {
  //         return User.fromJson(userJson)
  //           ..lastMessage = "Hey, how's it going?"
  //           ..lastMessageTime = "12:45 PM";
  //       }).toList();
  //     } else {
  //       throw Exception('Failed to fetch users: ${response.body}');
  //     }
  //   } catch (error) {
  //     print("Error in get user chats: $error");
  //   }
  // }

  // Send a message to another user
  Future<void> sendMessage(String recipientUserId, String message) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + APIENDPOINTS.messageEndpoints.sendMessage),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.value}',
        },
        body: json.encode({
          'recipient_user_id': recipientUserId,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Get.snackbar('Success', 'Message sent');
        // Optionally, handle any updates, such as refreshing message list or updating user
      } else {
        final data = json.decode(response.body);
        Get.snackbar('Error', data['message']);
        throw Exception('Failed to send message: ${response.body}');
      }
    } catch (error) {
      Get.snackbar('Error', 'Message sending failed');
      print("Error in sendMessage: $error");
    }
  }

  // Example usage of the sendMessage method within the chat UI
  Future<void> sendMessageToUser(String message) async {
    String recipientUserId =
        'someUserId'; // Set this dynamically based on the chat context
    await sendMessage(recipientUserId, message);
  }
}
