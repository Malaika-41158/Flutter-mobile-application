import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          SizedBox(height: 16),
          Text("Name: Sara Khan", style: TextStyle(fontSize: 18)),
          Text("Email: sara.khan@example.com"),
          SizedBox(height: 20),
          Text("About Me", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("This is the profile section. Can be edited and updated here."),
        ],
      ),
    );
  }
}