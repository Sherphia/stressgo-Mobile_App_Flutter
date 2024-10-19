import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stress_go/auth/auth_service.dart';
import 'package:stress_go/auth/signup_screen.dart';
import 'package:stress_go/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _auth = AuthService();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  int streakCount = 0; // Variable to hold the streak count
  String lastLoginDate = '';

  @override
  void initState() {
    super.initState();
    loadStreakCount();
  }

  // Load streak count and last login date from shared preferences
  Future<void> loadStreakCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      streakCount = prefs.getInt('streak_count') ?? 0; // Load streak count
      lastLoginDate = prefs.getString('last_login_date') ?? ''; // Load last login date
    });
  }

  // Update the streak count based on the last login date
  Future<void> updateStreak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime lastLogin = DateTime.tryParse(lastLoginDate) ?? DateTime.now().subtract(const Duration(days: 1));

    // Check if the last login date is today
    if (DateTime.now().difference(lastLogin).inDays >= 1) {
      // Increase streak count
      setState(() {
        streakCount += 1; // Increase streak count by 1
      });
    }

    // Update the last login date
    lastLoginDate = DateTime.now().toIso8601String();
    await prefs.setString('last_login_date', lastLoginDate);
    await prefs.setInt('streak_count', streakCount); // Save updated streak count
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Please sign in to continue.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Email TextField
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white24,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white24,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login, // Handle email and password login
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Removed Social sign-in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don’t have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );

  Future<void> _login() async {
    final user = await _auth.loginUserWithEmailAndPassword(
      _emailController.text, 
      _passwordController.text,
    );

    if (user != null) {
      log("User Logged In");
      // ignore: use_build_context_synchronously
      goToHome(context);
    }
  }
}
