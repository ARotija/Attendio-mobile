// lib/models/note.dart

class Note {
  final int id;
  final double value;
  final int studentId;
  final int courseId;
  final DateTime date;          // <-- nuevo
  final String? description;    // <-- nuevo (puede ser null)
  final String courseName;      // <-- nuevo

  Note({
    required this.id,
    required this.value,
    required this.studentId,
    required this.courseId,
    required this.date,
    this.description,
    required this.courseName,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as int,
      value: (json['value'] as num).toDouble(),
      studentId: json['student_id'] as int,
      courseId: json['course_id'] as int,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      courseName: (json['course']?['name'] as String?) ?? '—',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'student_id': studentId,
      'course_id': courseId,
      'date': date.toIso8601String().split('T').first,
      'description': description,
      // no hace falta mandar courseName al servidor
    };
  }
}
