// lib/models/attendance_record.dart

enum AttendanceStatus { present, absent }

AttendanceStatus _statusFromString(String value) {
  switch (value.toUpperCase()) {
    case 'PRESENT':
      return AttendanceStatus.present;
    case 'ABSENT':
      return AttendanceStatus.absent;
    default:
      throw Exception('Unknown attendance status: $value');
  }
}

class AttendanceRecord {
  final int id;
  final int userId;
  final int classroomId;
  final DateTime date;      // Solo la parte de fecha YYYY‑MM‑DD
  final int period;         // Periodo (1–6)
  final String status;      // Raw: "PRESENT" o "ABSENT"
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

  /// Convierte el `status` string al enum
  AttendanceStatus get statusEnum => _statusFromString(status);

  /// Crea una instancia a partir del JSON del backend
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

  /// Convierte esta instancia a JSON (por si la necesitas enviar)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'classroom_id': classroomId,
      'date': date.toIso8601String().split('T').first, // "YYYY‑MM‑DD"
      'period': period,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
