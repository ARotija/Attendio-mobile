import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  static Future<bool> login(String email, String password) async {
    final baseUrl = dotenv.env['API_URL']; // <- desde .env
    if (baseUrl == null) {
      throw Exception('API_URL no definida en el archivo .env');
    }

    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Aquí podrías guardar un token o la sesión
      return true;
    } else {
      // Puedes imprimir el error para debug
      print('Login fallido: ${response.statusCode}, ${response.body}');
      return false;
    }
  }
}
