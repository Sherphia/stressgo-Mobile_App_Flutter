import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HeartRateInput extends StatefulWidget {
  @override
  _HeartRateInputState createState() => _HeartRateInputState();
}

class _HeartRateInputState extends State<HeartRateInput> {
  final TextEditingController _heartRateController = TextEditingController();
  List<dynamic> _recommendations = [];

  void _getRecommendations() async {
    // Validate heart rate input
    if (_heartRateController.text.isEmpty) {
      print('Heart rate is empty');
      return; // Exit if input is empty
    }

    // Try to parse heart rate
    int? heartRate = int.tryParse(_heartRateController.text);
    if (heartRate == null) {
      print('Invalid heart rate');
      return; // Exit if input is invalid
    }

    // Make POST request to Flask API
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/recommend'), // Change this to your Flask API URL
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'heart_rate': heartRate}),
    );

    // Check response status
    if (response.statusCode == 200) {
      // Update state with recommendations
      setState(() {
        _recommendations = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Heart Rate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text field for heart rate input
            TextField(
              controller: _heartRateController,
              decoration: InputDecoration(
                labelText: 'Heart Rate',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number, // Show number keyboard
            ),
            SizedBox(height: 20), // Add space between elements

            // Button to get recommendations
            ElevatedButton(
              onPressed: () {
                _getRecommendations();
              },
              child: Text('Get Recommendations'),
            ),
            SizedBox(height: 20), // Add space between elements

            // Display recommendations
            Expanded(
              child: ListView.builder(
                itemCount: _recommendations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_recommendations[index]['song_title']),
                    subtitle: Text(_recommendations[index]['artist']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
