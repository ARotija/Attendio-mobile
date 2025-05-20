import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/whatsapp_message.dart';

class NotificationService {
  static Future<bool> sendWhatsappMessage(
    WhatsAppMessage message,
    String jwtToken,
  ) async {
    final baseUrl = dotenv.env['API_URL'];
    if (baseUrl == null) {
      throw Exception('API_URL no definida en el archivo .env');
    }

    final url = Uri.parse('$baseUrl/notifications/send-whatsapp');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken', // Token JWT necesario
        },
        body: jsonEncode(message.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error al enviar mensaje WhatsApp: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error de red al enviar WhatsApp: $e');
      return false;
    }
  }
}
