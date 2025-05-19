import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/course.dart';
import 'storage_service.dart';

class CourseService {
  static final String? _baseUrl = dotenv.env['API_URL'];

  static Future<List<Course>> getCourses() async {
    final token = await StorageService.getAccessToken();
    if (token == null) throw Exception('No access token found');

    final url = Uri.parse('$_baseUrl/api/v1/notes/courses');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) => Course.fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener cursos: ${response.body}');
    }
  }
}
