
import 'dart:convert';
import 'package:http/http.dart' as http;

class PracticalService {
  final String baseUrl = "http://10.0.2.2:3000/api";

  Future<List<Map<String, dynamic>>> getPracticals() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/practicals'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
