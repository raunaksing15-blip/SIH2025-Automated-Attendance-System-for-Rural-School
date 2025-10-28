import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://sih2025-automated-attendance-system-for-33fd.onrender.com'; // Replace with your backend URL

  Future<Uint8List> getQrCode(String courseId) async {
    final response = await http.get(Uri.parse('$_baseUrl/generate_qr?course_id=$courseId'));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to get QR code');
    }
  }

  Future<Map<String, dynamic>> markAttendance(String studentId, String courseId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/mark_attendance'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'student_id': studentId,
        'course_id': courseId,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to mark attendance');
    }
  }

  Future<Map<String, dynamic>> getAttendance(String studentId) async {
    final response = await http.get(Uri.parse('$_baseUrl/get_attendance?student_id=$studentId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get attendance');
    }
  }
}
