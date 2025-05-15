// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  // Método para hacer login y obtener el rol
  static Future<String?> login(String email, String password) async {
    final baseUrl = dotenv.env['API_URL']; // Usar URL desde el archivo .env
    if (baseUrl == null) {
      throw Exception('API_URL no definida en el archivo .env');
    }

    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Suponiendo que la respuesta contiene el rol del usuario
        return data['role'];  // Devuelve el rol (por ejemplo: 'teacher', 'student', 'tutor')
      } else {
        // Si la respuesta es diferente a 200, muestra el error para depuración
        print('Login fallido: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      return null;
    }
  }
}
//   } // Fin del método handleLogin