import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/auth_service.dart';
import 'login.dart';
import 'signup.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Future pickImage() async {
    final img = await ImagePicker()
        .pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() {
        AuthService.profilePic = img.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool login = AuthService.isLoggedIn;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: Center(
        child: login
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  InkWell(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AuthService.profilePic != null
                              ? FileImage(
                                  File(AuthService.profilePic!))
                              : const AssetImage(
                                      'assets/Pictures/logo.png')
                                  as ImageProvider,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    AuthService.username ?? "User",
                    style: const TextStyle(fontSize: 20),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      AuthService.logout();
                      setState(() {});
                    },
                    child: const Text("Logout"),
                  ),
                ],
              )

            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const SignupPage()),
                      );
                    },
                    child: const Text("Signup"),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const LoginPage()),
                      );
                    },
                    child: const Text("Login"),
                  )
                ],
              ),
      ),
    );
  }
}
