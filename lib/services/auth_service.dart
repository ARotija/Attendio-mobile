import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:attendio_mobile/services/api_client.dart';

class AuthService {
  static const _accessTokenKey = 'access_token';

  // Guardar token localmente
  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    ApiClient.accessToken = token;
  }

  // Leer token localmente
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_accessTokenKey);
    if (token != null) {
      ApiClient.accessToken = token;
    }
    return token;
  }

  // Borrar token localmente (logout)
  static Future<void> clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    ApiClient.accessToken = null;
  }

  // Login -> retorna rol o null
  static Future<String?> login(String email, String password) async {
    final response = await ApiClient.post('/auth/login', {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];
      if (token != null) {
        await saveAccessToken(token);
      }
      return data['user']['role']?.toString().toLowerCase();
    } else {
      print(jsonDecode(response.body)['error']);
      return null;
    }
  }

  // Registro -> retorna true si éxito, false si error
  static Future<bool> register(String email, String password, String role) async {
    final response = await ApiClient.post('/auth/register', {
      'email': email,
      'password': password,
      'role': role,
    });

    if (response.statusCode == 201) {
      return true;
    } else {
      print(jsonDecode(response.body)['error']);
      return false;
    }
  }

  // Recuperar contraseña -> retorna true si se envió email, false si error
  static Future<bool> forgotPassword(String email) async {
    final response = await ApiClient.post('/auth/forgot-password', {
      'email': email,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      print(jsonDecode(response.body)['error']);
      return false;
    }
  }
}