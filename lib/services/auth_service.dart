// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'storage_service.dart';
import 'user_service.dart'; // Para obtener el perfil tras el login
import '../models/user.dart';

class AuthService {
  /// Hace login en el backend, guarda tokens, rol e ID de usuario.
  /// Retorna `true` si todo fue exitoso.
  static Future<bool> login(String email, String password) async {
    final baseUrl = dotenv.env['API_URL'];
    if (baseUrl == null) {
      throw Exception('API_URL no definida en el archivo .env');
    }

    // 1️⃣ POST /api/v1/auth/login
    final loginUrl = Uri.parse('$baseUrl/api/v1/auth/login');
    try {
      final loginResp = await http.post(
        loginUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (loginResp.statusCode != 200) {
        print('Login fallido: ${loginResp.statusCode}, ${loginResp.body}');
        return false;
      }

      final loginData = json.decode(loginResp.body) as Map<String, dynamic>;

      // 2️⃣ Guardar access & refresh tokens
      await StorageService.saveAccessToken(loginData['access_token'] as String);
      await StorageService.saveRefreshToken(loginData['refresh_token'] as String);

      // 3️⃣ GET /api/v1/users/me para obtener perfil completo
      User me;
      try {
        me = await UserService.getMe();
      } catch (e) {
        print('Error obteniendo perfil de usuario tras login: $e');
        return false;
      }

      // 4️⃣ Guardar rol e ID en SharedPreferences
      await StorageService.saveRole(me.role.name);
      await StorageService.saveUserId(me.id);

      return true;
    } catch (e) {
      print('Error en la solicitud de login: $e');
      return false;
    }
  }

  /// Registra un usuario nuevo en el backend.
  /// Retorna `true` si se crea con éxito (201), `false` en caso contrario.
  static Future<bool> register({
    required String name,
    required String email,
    required String password,
    required int roleId, // según Swagger el campo es role_id
  }) async {
    final baseUrl = dotenv.env['API_URL'];
    if (baseUrl == null) {
      throw Exception('API_URL no definida en el archivo .env');
    }

    final url = Uri.parse('$baseUrl/api/v1/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'role_id': roleId,
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Registro fallido: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error en la solicitud de registro: $e');
      return false;
    }
  }

  /// Solicita el envío de un email para restablecer la contraseña.
  /// Retorna true si la petición fue aceptada (status 200).
  static Future<bool> requestReset(String email) async {
    final baseUrl = dotenv.env['API_URL'];
    if (baseUrl == null) {
      throw Exception('API_URL no definida en el archivo .env');
    }

    final url = Uri.parse('$baseUrl/api/v1/auth/request-reset');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      // Según Swagger, siempre devuelve 200 (aunque el email no exista)
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Request-reset fallido: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error en la solicitud request-reset: $e');
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
