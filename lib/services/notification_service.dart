import 'dart:convert';
import 'package:attendio_mobile/services/api_client.dart';

class NotificationService {
  static Future<bool> sendWhatsappSummary(int classroomId, int period) async {
    final response = await ApiClient.post('/notifications/send-whatsapp', {
      'classroom_id': classroomId,
      'period': period,
    });

    return response.statusCode == 200 && jsonDecode(response.body)['sent'] == true;
  }
}
