class AttendanceRecord {
  final int id;
  final int userId;
  final int classroomId;
  final DateTime date;      // Solo la parte de fecha YYYY-MM-DD
  final int period;         // Periodo (1–6)
  final String status;      // "PRESENT" o "ABSENT"
  final DateTime timestamp; // Fecha y hora completa

  AttendanceRecord({
    required this.id,
    required this.userId,
    required this.classroomId,
    required this.date,
    required this.period,
    required this.status,
    required this.timestamp,
  });

  /// Crea una instancia a partir de un JSON del backend
  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      classroomId: json['classroom_id'] as int,
      date: DateTime.parse(json['date'] as String),
      period: json['period'] as int,
      status: json['status'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  /// Convierte esta instancia a JSON (si alguna vez necesitas enviarla)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'classroom_id': classroomId,
      'date': date.toIso8601String().split('T').first, // "YYYY-MM-DD"
      'period': period,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
