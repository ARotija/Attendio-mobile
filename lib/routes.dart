import 'package:flutter/material.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/auth/forgot_password.dart';
import 'screens/teacher/home.dart';
import 'screens/teacher/notes.dart';
import 'screens/teacher/attendance.dart';
import 'screens/teacher/search.dart';
import 'screens/teacher/profile.dart';
import 'screens/student/home.dart';
import 'screens/student/notes.dart';
import 'screens/student/attendance.dart';
import 'screens/student/notifications.dart';
import 'screens/student/profile.dart';
import 'screens/tutor/home.dart';
import 'screens/tutor/notes.dart';
import 'screens/tutor/attendance.dart';
import 'screens/tutor/notifications.dart';
import 'screens/tutor/profile.dart';
import 'screens/tutor/add_child.dart';

/// Mapa de rutas para toda la aplicación
final Map<String, WidgetBuilder> appRoutes = {
  // Authentication
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/forgot-password': (context) => ForgotPasswordScreen(),

  // Teacher
  '/teacher/home':       (context) => TeacherHomeScreen(),
  '/teacher/notes':      (context) => TeacherNotesScreen(),
  '/teacher/attendance': (context) => TeacherAttendanceScreen(),
  '/teacher/search':     (context) => TeacherSearchScreen(),
  '/teacher/profile':    (context) => TeacherProfileScreen(),

  // Student
  '/student/home':         (context) => StudentHomeScreen(),
  '/student/notes':        (context) => StudentNotesScreen(),
  '/student/attendance':   (context) => StudentAttendanceScreen(),
  '/student/notifications':(context) => StudentNotificationsScreen(),
  '/student/profile':      (context) => StudentProfileScreen(),

  // Tutor
  '/tutor/home':         (context) => TutorHomeScreen(),
  '/tutor/notes':        (context) => TutorNotesScreen(),
  '/tutor/attendance':   (context) => TutorAttendanceScreen(),
  '/tutor/notifications':(context) => TutorNotificationsScreen(),
  '/tutor/profile':      (context) => TutorProfileScreen(),
  '/tutor/add-child': (context) => AddChildScreen(),
};