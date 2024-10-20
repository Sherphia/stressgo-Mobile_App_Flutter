import 'package:flutter_svg/svg.dart';
import 'auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For stylish fonts
import 'package:lottie/lottie.dart';
import 'auth/login_screen.dart'; // For GIF-like animations

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService auth = AuthService();
  int streakCount = 5; // Example streak count
  int heartRate = 72; // Simulated heart rate
  bool isExpanded = false; // For scroll-down functionality
  final ScrollController _scrollController = ScrollController(); // Create a ScrollController

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
            controller: _scrollController, // Assign the ScrollController
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
                const SizedBox(height: 10),
                // Streak Counter with animation progress bar
                Column(
                  children: [
                    const SizedBox(height: 10), // Add spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/fire.svg', // Your SVG file path
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
                    const SizedBox(height: 2), // Add spacing
                    Text(
                      "Days Logged In",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                // Meditating girl GIF
                GestureDetector(
                  onTap: () {
                    // Action when meditating girl GIF is clicked
                  },
                  child: Lottie.asset(
                    'assets/meditating_girl.json', // Place a meditating girl GIF/animation file here
                    height: 190, // Adjust height as needed
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 1),
                // Scroll down GIF button (placed between meditating girl and the row of GIFs)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded; // Toggle the expanded state
                    });
                    // Scroll down to the next section when GIF is tapped
                    if (isExpanded) {
                      _scrollController.animateTo(
                        _scrollController.position.pixels + 500, // Adjust scroll amount
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Lottie.asset(
                    'assets/scroll_down_gif.json', // Place a scroll-down GIF/animation file here
                    height: 70,
                    width: 30,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 40),
                // Expanded content when the scroll-down GIF is pressed
                if (isExpanded)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space them evenly
                        children: [
                          // First column: Breathing Test GIF and Text
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Breathing Test functionality here
                                },
                                child: Image.asset(
                                  'assets/breathing_test.gif', // Your GIF file path
                                  width: 150, // Adjust size for each GIF
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10), // Spacing between GIF and text
                              const Text(
                                'Breathing Test',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          // Second column: Music GIF and Text
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Spotify integration functionality here
                                },
                                child: Image.asset(
                                  'assets/music.gif', // Path to your music GIF
                                  width: 150, // Adjust size for each GIF
                                  height: 150,
                                ),
                              ),
                              const SizedBox(height: 10), // Spacing between GIF and text
                              const Text(
                                'Music',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Additional content after scrolling down
                      _expandedSection(),
                    ],
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Chat icon at the bottom right corner
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Action to open chat
              },
              child: Lottie.asset(
              'assets/chatbot.json', // Path to your chatbot animation JSON file
                width: 60, // Set the width of the chat icon
                height: 60, // Set the height of the chat icon
              ),
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
        ElevatedButton(
          onPressed: () {
            // More exercises here
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.deepPurpleAccent,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text('More Exercises'),
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
              TextButton(
                onPressed: () async {
                  await auth.signout(); // Call the signout method
                  // Optionally, navigate back to the login screen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text("Logout", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }
}
