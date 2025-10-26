
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:8080"; // Correct port for the Flask server

  Future<bool> markAttendance(String studentId, String courseId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/mark_attendance'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"student_id": studentId, "course_id": courseId}),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getAttendance(String studentId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_attendance?student_id=$studentId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['attendance']);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

class AttendanceDB {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'attendance.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE attendance(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            studentId TEXT,
            courseId TEXT,  // Added courseId
            timestamp TEXT,
            synced INTEGER
          )
        ''');
      },
    );
  }

  static Future<void> insertAttendance(String studentId, String courseId) async {
    final database = await db;
    await database.insert("attendance", {
      "studentId": studentId,
      "courseId": courseId,
      "timestamp": DateTime.now().toIso8601String(),
      "synced": 0,
    });
  }

  static Future<List<Map<String, dynamic>>> getUnsynced() async {
    final database = await db;
    return await database.query("attendance", where: "synced = 0");
  }

  static Future<void> markSynced(int id) async {
    final database = await db;
    await database.update("attendance", {"synced": 1}, where: "id = ?", whereArgs: [id]);
  }
}

class AttendanceManager {
  final ApiService apiService = ApiService();

  Future<void> submitAttendance(String studentId, String courseId) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // Offline - save locally
      await AttendanceDB.insertAttendance(studentId, courseId);
    } else {
      // Online - try to send to server
      bool success = await apiService.markAttendance(studentId, courseId);

      if (success) {
        // If successful, sync any offline data too
        await syncOfflineAttendance();
      } else {
        // If failed, save locally
        await AttendanceDB.insertAttendance(studentId, courseId);
      }
    }
  }

  Future<void> syncOfflineAttendance() async {
    final unsynced = await AttendanceDB.getUnsynced();
    
    for (var record in unsynced) {
      final studentId = record['studentId'];
      final courseId = record['courseId'];
      final int id = record['id'];

      bool success = await apiService.markAttendance(studentId, courseId);
      if (success) {
        await AttendanceDB.markSynced(id);
      }
    }
  }

  Future<List<Map<String, dynamic>>> getAttendance(String studentId) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // Optionally, you could fetch from local DB if offline
      return [];
    } else {
      await syncOfflineAttendance(); // Sync before fetching
      return await apiService.getAttendance(studentId);
    }
  }
}
