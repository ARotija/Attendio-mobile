import 'role.dart';

class User {
  final int id;
  final String name;
  final String email;
  final Role role;
  final int? classroomId;
  final String? studentCode;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.classroomId,
    this.studentCode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
      classroomId: json['classroom_id'] as int?,
      studentCode: json['student_code'] as String?,
    );
  }
}
