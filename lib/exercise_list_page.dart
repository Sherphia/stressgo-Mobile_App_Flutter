import 'package:flutter/material.dart';

class ExerciseListPage extends StatelessWidget {
  const ExerciseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercises"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          // Sample exercise items
          ListTile(
            leading: Icon(Icons.fitness_center, color: Colors.deepPurple),
            title: Text("Exercise 1"),
            subtitle: Text("Description of Exercise 1"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.fitness_center, color: Colors.deepPurple),
            title: Text("Exercise 2"),
            subtitle: Text("Description of Exercise 2"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.fitness_center, color: Colors.deepPurple),
            title: Text("Exercise 3"),
            subtitle: Text("Description of Exercise 3"),
          ),
          Divider(),
          // Add more exercises as needed
        ],
      ),
    );
  }
}
