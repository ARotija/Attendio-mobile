class WhatsAppMessage {
  final String to;
  final String message;

  WhatsAppMessage({
    required this.to,
    required this.message,
  });

  // Convierte el objeto a JSON para enviarlo al backend
  Map<String, dynamic> toJson() {
    return {
      'to': to,
      'message': message,
    };
  }
}
