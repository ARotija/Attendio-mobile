// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'storage_service.dart'; // Importa el servicio de almacenamiento

class AuthService {
  /// Hace login en el backend, guarda tokens, rol e ID de usuario, y retorna éxito.
  static Future<bool> login(String email, String password) async {
    final baseUrl = dotenv.env['API_URL'];
    if (baseUrl == null) {
      throw Exception('API_URL no definida en el archivo .env');
    }

    final url = Uri.parse('$baseUrl/api/v1/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        // Guardar access_token y refresh_token usando métodos separados
        await StorageService.saveAccessToken(data['access_token'] as String);
        await StorageService.saveRefreshToken(data['refresh_token'] as String);

        // Opcional: Si tu backend regresa rol e ID dentro de 'user'
        if (data.containsKey('user')) {
          final user = data['user'] as Map<String, dynamic>;
          await StorageService.saveRole(user['role'] as String);
          await StorageService.saveUserId(user['id'] as int);
        }

        return true; // Login exitoso
      } else {
        print('Login fallido: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      return false;
    }
  }

  /// Recupera el access token almacenado
  static Future<String?> getAccessToken() async {
    return await StorageService.getAccessToken();
  }

  /// Recupera el refresh token almacenado
  static Future<String?> getRefreshToken() async {
    return await StorageService.getRefreshToken();
  }

  /// Cierra sesión: borra tokens, rol e ID
  static Future<void> logout() async {
    await StorageService.clearSession();
  }
}
