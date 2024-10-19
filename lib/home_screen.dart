import 'auth/auth_service.dart';
import 'auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  // For stylish fonts
import 'package:lottie/lottie.dart';  // For GIF-like animations
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';  // For streak display

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService auth = AuthService();
  int streakCount = 5;  // Example streak count
  int heartRate = 72;  // Simulated heart rate
  bool isExpanded = false;  // For scroll-down functionality

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stress Go'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _openMenu(context);
          },
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Welcome text and smiling profile icon
                Column(
                  children: [
                    Text(
                      "Welcome back, User",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10), // Add some spacing
          ClipOval(
            child: Image.asset(
              'assets/profile.png', // Your profile image
              width: 100, // Set your desired width
              height: 100, // Set your desired height
              fit: BoxFit.cover, // Ensure the image covers the circular area
            ),
          ),
        ],
      ),
                const SizedBox(height: 20),
                // Streak Counter with animation progress bar
                // Replace the Streak Counter with animation progress bar
                Column(
                  children: [
                    const SizedBox(height: 20), // Add spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/fire.svg', // Your fire icon image
                          width: 50, // Set desired width for the icon
                          height: 50, // Set desired height for the icon
                        ),
                        const SizedBox(width: 10), // Add spacing
                        Text(
                          "$streakCount", // Display the streak count
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Add spacing
                    Text(
                      "Days Logged In",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                // Meditating girl GIF
                GestureDetector(
                  onTap: () {
                    // Action when meditating girl GIF is clicked
                  },
                  child: Lottie.asset(
                    'assets/meditating_girl.json',  // Place a meditating girl GIF/animation file here
                    height: 200,  // Adjust height as needed
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 40),
                // Breathing Test button
                ElevatedButton(
                  onPressed: () {
                    // Breathing Test functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.deepPurpleAccent, backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Take Breathing Test'),
                ),
                const SizedBox(height: 20),
                // Spotify Integration button
                ElevatedButton(
                  onPressed: () {
                    // Spotify integration functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.deepPurpleAccent, backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Integrate with Spotify'),
                ),
                
                const SizedBox(height: 20),
                // Scroll down GIF button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Lottie.asset(
                    'assets/scroll_down_gif.json',  // Place a scroll-down GIF/animation file here
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                // Expandable section when scroll-down is clicked
                if (isExpanded)
                  _expandedSection(),  // Additional content when expanded
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Additional content after scrolling down
  Widget _expandedSection() {
    return Column(
      children: [
        // Additional breathing exercises, settings, etc.
        ElevatedButton(
          onPressed: () {
            // More exercises here
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.deepPurpleAccent, backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text('More Exercises'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Open chat with bot or assistant
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.deepPurpleAccent, backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text('Chat with Assistant'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Side menu
  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.deepPurple,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.account_circle, color: Colors.white),
                title: const Text("Profile", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Navigate to profile
                },
              ),
              ListTile(
                leading: const Icon(Icons.gamepad, color: Colors.white),
                title: const Text("Go Games", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Navigate to games
                },
              ),
              ListTile(
                leading: const Icon(Icons.language, color: Colors.white),
                title: const Text("Language", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Change language
                },
              ),
              ListTile(
                leading: const Icon(Icons.watch, color: Colors.white),
                title: const Text("Connect Smart Watch", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Connect to smart watch
                },
              ),
              ListTile(
                leading: const Icon(Icons.brightness_6, color: Colors.white),
                title: const Text("Theme", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Change theme
                },
              ),
              const ListTile(
                title: Text("Stress_go", style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        );
      },
    );
  }
}
