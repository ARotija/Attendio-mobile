// lib/routes.dart

import 'package:flutter/material.dart';

// Auth
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/auth/forgot_password.dart';

// Teacher
import 'screens/teacher/home.dart';
import 'screens/teacher/notes.dart';
import 'screens/teacher/attendance.dart';
import 'screens/teacher/search.dart';
import 'screens/teacher/profile.dart';
import 'screens/teacher/scan.dart';
import 'screens/teacher/student_devices.dart';
import 'screens/teacher/manage_devices.dart';

// Student
import 'screens/student/home.dart';
import 'screens/student/notes.dart';
import 'screens/student/attendance.dart';
import 'screens/student/notifications.dart';
import 'screens/student/profile.dart';

// Tutor
import 'screens/tutor/home.dart';
import 'screens/tutor/notes.dart';
import 'screens/tutor/attendance.dart';
import 'screens/tutor/notifications.dart';
import 'screens/tutor/profile.dart';
import 'screens/tutor/add_child.dart';

class AppRoutes {
  // Authentication
  static const login            = '/login';
  static const register         = '/register';
  static const forgotPassword   = '/forgot-password';

  // Teacher
  static const teacherHome       = '/teacher/home';
  static const teacherNotes      = '/teacher/notes';
  static const teacherAttendance = '/teacher/attendance';
  static const teacherSearch     = '/teacher/search';
  static const teacherProfile    = '/teacher/profile';
  static const teacherScan       = '/teacher/scan';
  static const teacherStudentDevices = '/teacher/students';
  static const teacherManageDevices = '/teacher/students/devices';


  // Student
  static const studentHome          = '/student/home';
  static const studentNotes         = '/student/notes';
  static const studentAttendance    = '/student/attendance';
  static const studentNotifications = '/student/notifications';
  static const studentProfile       = '/student/profile';

  // Tutor
  static const tutorHome           = '/tutor/home';
  static const tutorNotes          = '/tutor/notes';
  static const tutorAttendance     = '/tutor/attendance';
  static const tutorNotifications  = '/tutor/notifications';
  static const tutorProfile        = '/tutor/profile';
  static const tutorAddChild       = '/tutor/add-child';
}

/// Mapa de rutas para toda la aplicación
final Map<String, WidgetBuilder> appRoutes = {
  // Authentication
  AppRoutes.login:          (context) => const LoginScreen(),
  AppRoutes.register:       (context) => const RegisterScreen(),
  AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),

  // Teacher
  AppRoutes.teacherHome:       (context) => const TeacherHomeScreen(),
  AppRoutes.teacherNotes:      (context) => const TeacherNotesScreen(),
  AppRoutes.teacherAttendance: (context) => const TeacherAttendanceScreen(),
  AppRoutes.teacherSearch:     (context) => TeacherSearchScreen(),
  AppRoutes.teacherProfile:    (context) => const TeacherProfileScreen(),
  AppRoutes.teacherScan:       (context) => const TeacherScanScreen(),
  AppRoutes.teacherStudentDevices: (context) => const StudentDevicesScreen(),
  AppRoutes.teacherManageDevices: (context) => const ManageDevicesScreen(),

  // Student
  AppRoutes.studentHome:          (context) => const StudentHomeScreen(),
  AppRoutes.studentNotes:         (context) => const StudentNotesScreen(),
  AppRoutes.studentAttendance:    (context) => const StudentAttendanceScreen(),
  AppRoutes.studentNotifications: (context) => StudentNotificationsScreen(),
  AppRoutes.studentProfile:       (context) => const StudentProfileScreen(),

  // Tutor
  AppRoutes.tutorHome:         (context) => TutorHomeScreen(),
  AppRoutes.tutorNotes:        (context) => const TutorNotesScreen(),
  AppRoutes.tutorAttendance:   (context) => const TutorAttendanceScreen(),
  AppRoutes.tutorNotifications:(context) => TutorNotificationsScreen(),
  AppRoutes.tutorProfile:      (context) => const TutorProfileScreen(),
  AppRoutes.tutorAddChild:     (context) => const AddChildScreen(),
};
