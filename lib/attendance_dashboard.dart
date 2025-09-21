import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AttendanceApi {
  final String baseUrl = 'http://YOUR-SERVER-IP:3000'; // Update with your server

  Future<List<dynamic>> fetchAttendanceRecords() async {
    final response = await http.get(Uri.parse('$baseUrl/attendance'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch attendance records');
    }
  }
}

class AttendanceDashboard extends StatefulWidget {
  const AttendanceDashboard({Key? key}) : super(key: key);

  @override
  _AttendanceDashboardState createState() => _AttendanceDashboardState();
}

class _AttendanceDashboardState extends State<AttendanceDashboard> {
  late Future<List<dynamic>> _attendanceFuture;

  @override
  void initState() {
    super.initState();
    _attendanceFuture = AttendanceApi().fetchAttendanceRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Dashboard')),
      body: FutureBuilder<List<dynamic>>(
        future: _attendanceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No attendance records found.'));
          }

          final records = snapshot.data!;

          return ListView.separated(
            itemCount: records.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final record = records[index];
              String studentId = record['studentid'] ?? 'Unknown';
              String timestamp = record['timestamp'] ?? 'Unknown';

              return ListTile(
                leading: const Icon(Icons.person),
                title: Text('Student ID: $studentId'),
                subtitle: Text('Marked at: $timestamp'),
              );
            },
          );
        },
      ),
    );
  }
}
