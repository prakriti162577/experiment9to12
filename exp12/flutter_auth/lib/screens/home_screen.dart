import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_screen.dart'; // ✅ Add this import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void handleLogout(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context); // ✅ capture before await
    await FirebaseAuth.instance.signOut();
    messenger.showSnackBar(
      const SnackBar(content: Text('Logged out')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
            tooltip: 'Profile',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => handleLogout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home Screen!'),
            const SizedBox(height: 10),
            Text('Logged in as: ${user?.email ?? user?.phoneNumber ?? "Unknown"}'),
          ],
        ),
      ),
    );
  }
}