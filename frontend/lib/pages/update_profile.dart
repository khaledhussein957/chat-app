import 'package:flutter/material.dart';
import 'package:frontend/services/user_services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Import for image picking

class UpdateProfileInfoScreen extends StatefulWidget {
  const UpdateProfileInfoScreen({super.key});

  @override
  _UpdateProfileInfoScreenState createState() =>
      _UpdateProfileInfoScreenState();
}

class _UpdateProfileInfoScreenState extends State<UpdateProfileInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final UserController userController = Get.put(UserController());
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    // Pre-populate the fields with the current user data
    nameController.text = userController.user['name'] ?? '';
    bioController.text = userController.user['bio'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Profile Info'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Update your name'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: bioController,
                    decoration: InputDecoration(labelText: 'Update your bio'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Image'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _pickImage,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    // width: 245, height: 36.52,
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(245, 36.52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () {
                      String updatedName = nameController.text;
                      String updatedBio = bioController.text;
                      userController.updateProfile(
                          updatedName, updatedBio, _image);
                    },
                    child: Text('Update'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
