import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/device.dart';

class DeviceService {
  static String get _baseUrl => dotenv.env['API_URL']!;

  /// Helper para obtener el token JWT almacenado
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  /// POST /api/v1/devices/users/{userId}/devices
  /// Asigna un dispositivo BLE a un alumno
  static Future<Device> addDevice({
    required int userId,
    required String deviceId,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception('No access token found');

    final uri = Uri.parse('$_baseUrl/api/v1/devices/users/$userId/devices');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'device_id': deviceId}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return Device.fromJson(data);
    } else {
      throw Exception('Failed to add device: ${response.statusCode} ${response.body}');
    }
  }

  /// GET /api/v1/devices/users/{userId}/devices
  /// Lista todos los dispositivos asignados a un alumno
  static Future<List<Device>> listDevices(int userId) async {
    final token = await _getToken();
    if (token == null) throw Exception('No access token found');

    final uri = Uri.parse('$_baseUrl/api/v1/devices/users/$userId/devices');
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list
          .map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to list devices: ${response.statusCode} ${response.body}');
    }
  }

  /// DELETE /api/v1/devices/users/{userId}/devices/{deviceId}
  /// Desvincula (desactiva) un dispositivo de un alumno
  static Future<void> removeDevice({
    required int userId,
    required String deviceId,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception('No access token found');

    final uri = Uri.parse('$_baseUrl/api/v1/devices/users/$userId/devices/$deviceId');
    final response = await http.delete(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove device: ${response.statusCode} ${response.body}');
    }
  }
}