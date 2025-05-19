import 'package:flutter/material.dart';
import 'package:attendio_mobile/services/user_service.dart';
import 'package:attendio_mobile/models/user.dart';
import 'package:attendio_mobile/routes.dart';
import '../../widgets/scaffolds/teacher_scaffold.dart';

class StudentDevicesScreen extends StatefulWidget {
  static const routeName = AppRoutes.teacherStudentDevices;

  const StudentDevicesScreen({super.key});

  @override
  _StudentDevicesScreenState createState() => _StudentDevicesScreenState();
}

class _StudentDevicesScreenState extends State<StudentDevicesScreen> {
  late Future<List<User>> _futureStudents;

  @override
  void initState() {
    super.initState();
    _futureStudents = UserService.getAll()
      .then((all) => all.where((u) => u.role.name == 'STUDENT').toList());
  }

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 4, // Nuevo índice si quieres, o ajusta al tuyo
      title: 'Gestionar Dispositivos',
      body: FutureBuilder<List<User>>(
        future: _futureStudents,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final students = snap.data!;
          if (students.isEmpty) {
            return const Center(child: Text('No hay alumnos registrados.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: students.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, i) {
              final u = students[i];
              return ListTile(
                leading: CircleAvatar(child: Text(u.name[0])),
                title: Text(u.name),
                subtitle: Text(u.email),
                trailing: TextButton(
                  child: const Text('Dispositivos'),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.teacherManageDevices,
                      arguments: {'userId': u.id, 'userName': u.name},
                    );
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
