import 'dart:convert';
import 'package:attendio_mobile/services/api_client.dart';

class ClassroomService {
  static Future<List<dynamic>?> getAllClassrooms() async {
    final response = await ApiClient.get('/classrooms');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> getClassroom(int id) async {
    final response = await ApiClient.get('/classrooms/$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<bool> createClassroom(String name) async {
    final response = await ApiClient.post('/classrooms', {'name': name});
    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> updateClassroom(int id, Map<String, dynamic> payload) async {
    final response = await ApiClient.patch('/classrooms/$id', payload);
    return response.statusCode == 200;
  }

  static Future<bool> deleteClassroom(int id) async {
    final response = await ApiClient.delete('/classrooms/$id');
    return response.statusCode == 200;
  }
}
