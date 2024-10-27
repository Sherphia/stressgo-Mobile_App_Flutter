import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stressgo/heart_rate_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showOptions = false;

  // Function to generate a random gradient background
  List<Color> _generateRandomGradient() {
    List<Color> gradientColors = [
      Colors.purple,
      Colors.blue,
      Colors.cyan,
      Colors.green,
      Colors.pink,
      Colors.orange,
      Colors.yellow
    ];
    gradientColors.shuffle(Random());
    return [gradientColors[0], gradientColors[1]];
  }

  void _scrollToBottom() {
    setState(() {
      _showOptions = true; // Show options after scrolling
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  // New function to recommend a song based on heartbeat
  void _recommendSong() {
    // Placeholder for song recommendation logic
    print("Recommending a song based on heartbeat...");
    // You can later implement the logic to get heartbeat data and recommend a song here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Stress Go"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Properly open the drawer using the Builder context
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.blueAccent],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text("Username"),
                accountEmail: Text("user@example.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.games, color: Colors.white),
                title: const Text("Go Games"),
                onTap: () {
                  // Handle Go Games action
                },
              ),
              ListTile(
                leading: const Icon(Icons.language, color: Colors.white),
                title: const Text("Language"),
                onTap: () {
                  // Handle Language action
                },
              ),
              ListTile(
                leading: const Icon(Icons.palette, color: Colors.white),
                title: const Text("Theme"),
                onTap: () {
                  // Handle Theme action
                },
              ),
              ListTile(
                leading: const Icon(Icons.watch, color: Colors.white),
                title: const Text("Connect Smart Watch"),
                onTap: () {
                  // Handle Connect Smart Watch action
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text("Logout"),
                onTap: () {
                  // Handle logout
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _generateRandomGradient(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(height: 30),
              // Welcome message with profile picture
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Welcome, User!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Meditating girl animation
              Lottie.asset(
                'assets/meditating_girl.json',
                height: 150,
              ),
              const SizedBox(height: 20),
              // Scroll down animation to reveal hidden options
              GestureDetector(
                onTap: _scrollToBottom,
                child: Lottie.asset(
                  'assets/scroll_down_gif.json',
                  height: 50,
                ),
              ),
              // Conditionally show the hidden options
              if (_showOptions) ...[
                // Streak Counter
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_fire_department, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        "Streak: 1 day",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Breathing Test and Exercise options
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Breathing Test action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 116, 169, 243),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text("Start Breathing Test"),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        // More Exercises action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 116, 169, 243),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text("More Exercises"),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HeartRateInput()), // Navigate to the new screen
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 116, 169, 243),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text("Recommend a Song"),
                  ),
                  ],
                ),
                const SizedBox(height: 20),
                // Additional exercises and options section
                GestureDetector(
                  onTap: () {
                    // Navigate to additional exercises page
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 116, 169, 243),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Additional Exercises",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open Chatbot
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.chat),
      ),
    );
  }
}
