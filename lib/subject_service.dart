
import 'dart:convert';
import 'package:http/http.dart' as http;

class SubjectService {
  final String baseUrl = "http://10.0.2.2:3000/api";

  Future<List<String>> getSubjects() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/subjects'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((subject) => subject['name'] as String).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
