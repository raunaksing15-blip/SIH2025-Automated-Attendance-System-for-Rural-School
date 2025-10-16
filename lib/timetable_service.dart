
import 'dart:convert';
import 'package:http/http.dart' as http;

class TimetableService {
  final String baseUrl = "http://10.0.2.2:3000/api";

  Future<List<Map<String, dynamic>>> getTimetable() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/timetable'));
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
