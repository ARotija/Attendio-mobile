// lib/services/attendance_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/attendance_record.dart';

class AttendanceService {
  static String get _baseUrl => dotenv.env['API_URL']!;

  /// Helper para obtener el token JWT almacenado
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  /// GET /api/v1/attendance?classroom_id=&period=&date=
  static Future<List<AttendanceRecord>> getRecords({
    int? classroomId,
    int? period,
    String? date, // formato YYYY-MM-DD
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception('No access token found');

    // Construir URI con query params
    final uri = Uri.parse('$_baseUrl/api/v1/attendance').replace(
      queryParameters: {
        if (classroomId != null) 'classroom_id': classroomId.toString(),
        if (period      != null) 'period':       period.toString(),
        if (date        != null) 'date':         date,
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'Content-Type' : 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body) as List<dynamic>;
      return list
          .map((e) => AttendanceRecord.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Failed to load attendance records (${response.statusCode}): ${response.body}'
      );
    }
  }

  /// POST /api/v1/attendance/scan
  /// Body: { "classroom_id": 1, "period": 2, "device_ids": [...] }
  static Future<List<AttendanceRecord>> scanAttendance({
    required int classroomId,
    required int period,
    required List<String> deviceIds,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception('No access token found');

    final uri = Uri.parse('$_baseUrl/api/v1/attendance/scan');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type' : 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'classroom_id': classroomId,
        'period'      : period,
        'device_ids'  : deviceIds,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> records = data['records'] as List<dynamic>;
      return records
          .map((e) => AttendanceRecord.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Failed to record attendance (${response.statusCode}): ${response.body}'
      );
    }
  }
}
