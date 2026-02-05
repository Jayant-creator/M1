import 'package:flutter/material.dart';
import 'profile.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onTheme;

  const HomeScreen({super.key, required this.onTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("M¹"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },

            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/Pictures/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        actions: [
          IconButton(
            onPressed: onTheme,
            icon: const Icon(Icons.brightness_6),
          )
        ],
      ),

      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Welcome to M¹ App",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
