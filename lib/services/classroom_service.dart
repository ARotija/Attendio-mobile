import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/classroom.dart';
import 'storage_service.dart';

class ClassroomService {
  static String get _baseUrl => dotenv.env['API_URL']!;

  /// Obtiene el JWT almacenado
  static Future<String?> _getToken() => StorageService.getAccessToken();

  /// Llama a GET /api/v1/classrooms y devuelve la lista de aulas.
  static Future<List<Classroom>> getClassrooms() async {
    final token = await _getToken();
    final url = Uri.parse('$_baseUrl/api/v1/classrooms');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body) as List<dynamic>;
      return data
          .map((e) => Classroom.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
          'Eroare la încărcarea sălilor: ${response.statusCode}, ${response.body}');
    }
  }
}
