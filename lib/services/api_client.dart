import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'; // ← Importa dotenv

class ApiClient {
  static final baseUrl = dotenv.env['API_URL'] ?? ''; // ← Toma la URL desde .env
  static String? accessToken;

  static Map<String, String> get headers {
    final headers = {'Content-Type': 'application/json'};
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> data) {
    return http.post(
      Uri.parse('${baseUrl.replaceAll(RegExp(r"/$"), "")}$endpoint'),
      headers: headers,
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> get(String endpoint) {
    return http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
  }

  static Future<http.Response> patch(String endpoint, Map<String, dynamic> data) {
    return http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> delete(String endpoint) {
    return http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
  }
}