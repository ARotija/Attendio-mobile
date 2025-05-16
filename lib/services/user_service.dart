import 'dart:convert';
import 'package:attendio_mobile/services/api_client.dart';

class UserService {
  static Future<List<dynamic>?> getAllUsers() async {
    final response = await ApiClient.get('/users');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> getUser(int id) async {
    final response = await ApiClient.get('/users/$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<bool> updateUser(int id, Map<String, dynamic> payload) async {
    final response = await ApiClient.patch('/users/$id', payload);
    return response.statusCode == 200;
  }

  static Future<bool> deleteUser(int id) async {
    final response = await ApiClient.delete('/users/$id');
    return response.statusCode == 200;
  }
}
