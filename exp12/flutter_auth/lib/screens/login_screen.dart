import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'phone_input_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  void handleEmailLogin() async {
    final messenger = ScaffoldMessenger.of(context);
    final user = await authService.signIn(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    messenger.showSnackBar(
      SnackBar(content: Text(user != null ? 'Login successful!' : 'Login failed')),
    );
  }

  void handleGoogleLogin() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      messenger.showSnackBar(const SnackBar(content: Text('Google login successful!')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Google login failed: $e')));
    }
  }

  void navigateToPhoneLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PhoneInputScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.flutter_dash, size: 80, color: Colors.white),
                const SizedBox(height: 24),
                const Text(
                  'Welcome to FlowerAuth 🌸',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildTextField(emailController, 'Email'),
                const SizedBox(height: 16),
                _buildTextField(passwordController, 'Password', obscure: true),
                const SizedBox(height: 24),
                _buildButton('Login with Email', Icons.email, handleEmailLogin),
                const SizedBox(height: 16),
                _buildButton('Login with Phone OTP', Icons.phone, navigateToPhoneLogin),
                const SizedBox(height: 16),
                _buildButton('Login with Google', Icons.login, handleGoogleLogin),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildButton(String label, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueAccent,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 4,
      ),
      icon: Icon(icon),
      label: Text(label),
      onPressed: onTap,
    );
  }
}