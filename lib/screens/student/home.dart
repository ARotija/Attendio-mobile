// lib/screens/student/home.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/widgets/scaffolds/student_scaffold.dart';
import 'package:attendio_mobile/routes.dart';
import 'package:attendio_mobile/services/user_service.dart';
import 'package:attendio_mobile/services/course_service.dart';
import 'package:attendio_mobile/models/user.dart';
import 'package:attendio_mobile/models/course.dart';

class StudentHomeScreen extends StatefulWidget {
  static const routeName = AppRoutes.studentHome;

  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  late final Future<User> _futureMe;
  late final Future<List<Course>> _futureMyCourses;

  @override
  void initState() {
    super.initState();
    _futureMe = UserService.getMe();
    _futureMyCourses = _futureMe.then((me) async {
      // Carga todos los cursos y filtra por el aula del alumno
      final all = await CourseService.getCourses();
      return all.where((c) => c.id == me.classroomId).toList();
      // nota: si Course.classroomId no existe en tu modelo, cambia a:
      //    return all.where((c) => c.name.startsWith(me.classroomName ?? '')).toList();
      // o cualquier lógica que relacione curso ↔ aula
    });
  }

  @override
  Widget build(BuildContext context) {
    return StudentScaffold(
      currentIndex: 0,
      notificationCount: 0,
      onNotificationTap: () =>
          Navigator.pushNamed(context, AppRoutes.studentNotifications),
      body: FutureBuilder<List<Course>>(
        future: _futureMyCourses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child:
                    Text('Eroare la încărcarea cursurilor: ${snapshot.error}'));
          }
          final courses = snapshot.data!;
          if (courses.isEmpty) {
            return const Center(child: Text('Nu ai cursuri asignate.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Cursurile tale',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              }
              final course = courses[index - 1];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(course.name),
                  subtitle: const Text('Detalii curs…'),
                  onTap: () {
                    // Aquí podrías navegar a una pantalla de detalles de curso
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
