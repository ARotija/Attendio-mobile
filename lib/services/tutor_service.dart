import 'dart:convert';
import 'package:attendio_mobile/services/api_client.dart';

class TutorService {
  static Future<List<dynamic>?> getChildren() async {
    final response = await ApiClient.get('/tutor/children');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<bool> addChild(String studentCode) async {
    final response = await ApiClient.post('/tutor/children', {
      'student_code': studentCode,
    });

    return response.statusCode == 200 && jsonDecode(response.body)['linked'] == true;
  }

  static Future<bool> removeChild(int studentId) async {
    final response = await ApiClient.delete('/tutor/children/$studentId');
    return response.statusCode == 200 && jsonDecode(response.body)['removed'] == true;
  }
}
