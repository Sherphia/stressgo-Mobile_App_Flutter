import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchRecommendations(int heartRate) async {
  final url = Uri.parse('http://127.0.0.1:5000/recommend'); // Use the local URL from your Flask server

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: json.encode({"heart_rate": heartRate}),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Failed to load recommendations");
  }
}
