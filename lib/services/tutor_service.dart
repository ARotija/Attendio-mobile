// lib/services/tutor_service.dart

import 'dart:convert';                              // ← Necesario para jsonEncode / json.decode
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'storage_service.dart';
import '../models/user.dart';

class TutorService {
  static String get _baseUrl => dotenv.env['API_URL']!;

  /// Helper para leer el access token JWT
  static Future<String?> _getToken() async {
    return await StorageService.getAccessToken();
  }

  /// GET /api/v1/tutor/children
  /// Devuelve la lista de hijos (User) vinculados al tutor.
  static Future<List<User>> getChildren() async {
    final token = await _getToken();
    if (token == null) throw Exception('No access token found');

    final uri = Uri.parse('$_baseUrl/api/v1/tutor/children');
    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (resp.statusCode == 200) {
      final List<dynamic> list = json.decode(resp.body) as List<dynamic>;
      return list.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch children: ${resp.body}');
    }
  }

  /// POST /api/v1/tutor/children
  /// Envía { student_code } para vincular un hijo.
  /// Devuelve `true` si se creó el enlace (201).
  static Future<bool> addChild(String studentCode) async {
    final token = await _getToken();
    if (token == null) throw Exception('No access token found');

    final uri = Uri.parse('$_baseUrl/api/v1/tutor/children');
    final resp = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'student_code': studentCode}),
    );

    return resp.statusCode == 201;
  }

  /// DELETE /api/v1/tutor/children/{link_id}
  /// Desvincula al hijo con ese link_id.
  /// Devuelve `true` si se eliminó correctamente (200).
  static Future<bool> removeChild(int linkId) async {
    final token = await _getToken();
    if (token == null) throw Exception('No access token found');

    final uri = Uri.parse('$_baseUrl/api/v1/tutor/children/$linkId');
    final resp = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return resp.statusCode == 200;
  }
}
