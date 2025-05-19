// lib/models/role.dart

enum Role {
  student,  // 1
  teacher,  // 2
  tutor,    // 3
  admin,    // 4
  unknown,
}

extension RoleExtension on Role {
  static Role fromId(int id) {
    switch (id) {
      case 1:
        return Role.student;
      case 2:
        return Role.teacher;
      case 3:
        return Role.tutor;
      case 4:
        return Role.admin;
      default:
        return Role.unknown;
    }
  }

  int get id {
    switch (this) {
      case Role.student:
        return 1;
      case Role.teacher:
        return 2;
      case Role.tutor:
        return 3;
      case Role.admin:
        return 4;
      default:
        return -1;
    }
  }

  String get name {
    switch (this) {
      case Role.student:
        return 'STUDENT';
      case Role.teacher:
        return 'TEACHER';
      case Role.tutor:
        return 'TUTOR';
      case Role.admin:
        return 'ADMIN';
      default:
        return 'UNKNOWN';
    }
  }
}
