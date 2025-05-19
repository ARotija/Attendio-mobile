// lib/models/user.dart

import 'role.dart';

class User {
  final int id;
  final String name;
  final String email;
  final Role role;
  final int? classroomId;
  final String? classroomName; // ← Nombre del aula si está disponible
  final String? studentCode;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.classroomId,
    this.classroomName,
    this.studentCode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: RoleExtension.fromId(json['role'] as int),
      classroomId: json['classroom_id'] as int?,
      classroomName: json['classroom'] != null
          ? json['classroom']['name'] as String?
          : null,
      studentCode: json['student_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role_id': role.id,
      'classroom_id': classroomId,
      'student_code': studentCode,
      // No se envían classroomName ni role.name ya que no los espera el backend
    };
  }
}
