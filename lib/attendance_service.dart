
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:3000/api"; // Replace with your backend API address

  Future<bool> markAttendance(String studentId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/attendance'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"student_id": studentId}),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
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
            timestamp TEXT,
            synced INTEGER
          )
        ''');
      },
    );
  }

  static Future<void> insertAttendance(String studentId) async {
    final database = await db;
    await database.insert("attendance", {
      "studentId": studentId,
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

  Future<void> submitAttendance(String studentId) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // Offline - save locally
      await AttendanceDB.insertAttendance(studentId);
    } else {
      // Online - try to send to server
      bool success = await apiService.markAttendance(studentId);

      if (success) {
        // If successful, sync any offline data too
        await syncOfflineAttendance();
      } else {
        // If failed, save locally
        await AttendanceDB.insertAttendance(studentId);
      }
    }
  }

  Future<void> syncOfflineAttendance() async {
    final unsynced = await AttendanceDB.getUnsynced();
    
    for (var record in unsynced) {
      final studentId = record['studentId'];
      final int id = record['id'];

      bool success = await apiService.markAttendance(studentId);
      if (success) {
        await AttendanceDB.markSynced(id);
      }
    }
  }
}
