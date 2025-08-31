import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Card(child: ListTile(title: Text("Welcome to Home"), subtitle: Text("This is the home section."))),
        Card(child: ListTile(title: Text("Latest News"), subtitle: Text("Some updates here..."))),
        Card(child: ListTile(title: Text("Quick Access"), subtitle: Text("Shortcuts to features."))),
      ],
    );
  }
}