import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void handleLogout(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context); // ✅ capture before await
    final navigator = Navigator.of(context); // ✅ capture before await

    await FirebaseAuth.instance.signOut();

    messenger.showSnackBar(
      const SnackBar(content: Text('Logged out')),
    );

    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => handleLogout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Info',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('UID: ${user?.uid ?? "Unknown"}'),
            const SizedBox(height: 8),
            Text('Email: ${user?.email ?? "Not available"}'),
            Text('Phone: ${user?.phoneNumber ?? "Not available"}'),
          ],
        ),
      ),
    );
  }
}