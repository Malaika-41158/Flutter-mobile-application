import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const UserProfilesApp());
}

class UserProfilesApp extends StatelessWidget {
  const UserProfilesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Profiles',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<dynamic>> users;

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(
      Uri.parse("https://randomuser.me/api/?results=10"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["results"];
    } else {
      throw Exception("Failed to load users (code: ${response.statusCode})");
    }
  }

  @override
  void initState() {
    super.initState();
    users = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Profiles")),
      body: FutureBuilder<List<dynamic>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users found"));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final user = data[index];
                final name = "${user["name"]["first"]} ${user["name"]["last"]}";
                final email = user["email"];
                final phone = user["phone"];
                final city = user["location"]["city"];
                final picture = user["picture"]["thumbnail"];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(picture),
                    ),
                    title: Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: $email"),
                        Text("Phone: $phone"),
                        Text("City: $city"),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}