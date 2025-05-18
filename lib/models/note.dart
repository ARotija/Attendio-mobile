class Note {
  final int id;
  final String description;
  final double value;
  final int courseId;
  final int studentId;

  Note({
    required this.id,
    required this.description,
    required this.value,
    required this.courseId,
    required this.studentId,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      description: json['description'],
      value: (json['value'] as num).toDouble(),
      courseId: json['course_id'],
      studentId: json['student_id'],
    );
  }
}
