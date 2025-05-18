import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../services/storage_service.dart'; // Importa StorageService
import '../models/user.dart';

class UserService {
  static String get baseUrl => dotenv.env['API_URL']!;

  /// Helper para obtener el token JWT guardado usando StorageService
  static Future<String?> _getToken() async {
    return await StorageService.getAccessToken();
  }

  /// GET /api/v1/users/me
  static Future<User> getMe() async {
    final token = await _getToken();
    if (token == null) throw Exception('No access token found');

    final url = Uri.parse('$baseUrl/api/v1/users/me');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return User.fromJson(data);
    } else {
      throw Exception('Failed to fetch profile: ${response.body}');
    }
  }

  /// GET /api/v1/users/  — Listar todos los usuarios
  static Future<List<User>> getAll() async {
    final token = await _getToken();
    if (token == null) throw Exception('No access token found');

    final url = Uri.parse('$baseUrl/api/v1/users/');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List<dynamic>;
      return list.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch users: ${response.body}');
    }
  }

  /// POST /api/v1/users/{id}/reset-code
  static Future<String> resetStudentCode(int userId) async {
    final token = await _getToken();
    if (token == null) throw Exception('No access token found');

    final url = Uri.parse('$baseUrl/api/v1/users/$userId/reset-code');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data['student_code'] as String;
    } else {
      throw Exception('Failed to reset code: ${response.body}');
    }
  }
}
