import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/note.dart';
import 'storage_service.dart';

class NoteService {
  static final String? _baseUrl = dotenv.env['API_URL'];

  static Future<List<Note>> getNotesByStudent(int studentId) async {
    final token = await StorageService.getAccessToken();
    if (token == null) throw Exception('No access token found');

    final url = Uri.parse('$_baseUrl/api/v1/notes/students/$studentId/notes');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) => Note.fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener notas del estudiante: ${response.body}');
    }
  }

  static Future<void> createNote({
    required String description,
    required double value,
    required int studentId,
    required int courseId,
  }) async {
    final token = await StorageService.getAccessToken();
    if (token == null) throw Exception('No access token found');

    final url = Uri.parse('$_baseUrl/students/$studentId/notes');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'description': description,
        'value': value,
        'course_id': courseId,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear nota: ${response.body}');
    }
  }
}
