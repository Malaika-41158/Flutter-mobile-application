import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        SwitchListTile(
          value: true,
          onChanged: null,
          title: Text("Dark Mode"),
        ),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text("Privacy"),
          subtitle: Text("Manage your privacy settings"),
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text("Notifications"),
          subtitle: Text("Customize notification preferences"),
        ),
      ],
    );
  }
}