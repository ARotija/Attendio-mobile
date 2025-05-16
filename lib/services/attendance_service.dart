import 'dart:convert';
import 'package:attendio_mobile/services/api_client.dart';

class AttendanceService {
  // POST /attendance/scan
  static Future<List<dynamic>?> scanAttendance(int classroomId, int period) async {
    final response = await ApiClient.post('/attendance/scan', {
      'classroom_id': classroomId,
      'period': period,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results']; // lista de {name, status}
    }
    return null;
  }

  // GET /attendance?classroom_id=&period=&date=
  static Future<Map<String, dynamic>?> getAttendance({int? classroomId, int? period, String? date}) async {
    String query = '?';
    if (classroomId != null) query += 'classroom_id=$classroomId&';
    if (period != null) query += 'period=$period&';
    if (date != null) query += 'date=$date&';
    if (query == '?') query = '';

    final response = await ApiClient.get('/attendance$query');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
