// lib/screens/teacher/home.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/widgets/scaffolds/teacher_scaffold.dart';
import 'package:attendio_mobile/services/classroom_service.dart';
import 'package:attendio_mobile/models/classroom.dart';
import 'package:attendio_mobile/routes.dart';

class TeacherHomeScreen extends StatelessWidget {
  static const routeName = AppRoutes.teacherHome;

  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 0,
      title: 'Clase asignate',
      body: FutureBuilder<List<Classroom>>(
        future: ClassroomService.getClassrooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Eroare la încărcarea sălilor: ${snapshot.error}'));
          }
          final classrooms = snapshot.data!;
          if (classrooms.isEmpty) {
            return const Center(child: Text('Nu ai săli atribuite.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: classrooms.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, i) {
              final room = classrooms[i];
              return ListTile(
                leading: const Icon(Icons.class_),
                title: Text(room.name),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Ir a la pantalla de asistencia, pasando classroom_id como argumento
                  Navigator.pushNamed(
                    context,
                    AppRoutes.teacherAttendance,
                    arguments: {'classroom_id': room.id},
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
