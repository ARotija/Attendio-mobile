// lib/screens/teacher/notes.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/services/classroom_service.dart';
import 'package:attendio_mobile/models/classroom.dart';
import 'package:attendio_mobile/widgets/scaffolds/teacher_scaffold.dart';
import 'package:attendio_mobile/routes.dart';

class TeacherNotesScreen extends StatefulWidget {
  static const routeName = AppRoutes.teacherNotes;

  const TeacherNotesScreen({super.key});

  @override
  State<TeacherNotesScreen> createState() => _TeacherNotesScreenState();
}

class _TeacherNotesScreenState extends State<TeacherNotesScreen> {
  late Future<List<Classroom>> _futureClasses;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _futureClasses = ClassroomService.getClassrooms();
  }

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 1,
      title: 'Note elevilor',
      body: Column(
        children: [
          // campo de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (v) => setState(() => _search = v.trim().toLowerCase()),
              decoration: InputDecoration(
                hintText: 'Caută clasă...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
            ),
          ),

          // lista de aulas
          Expanded(
            child: FutureBuilder<List<Classroom>>(
              future: _futureClasses,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(child: Text('Eroare: ${snap.error}'));
                }
                var classes = snap.data!
                    .where((c) => c.name.toLowerCase().contains(_search))
                    .toList();
                if (classes.isEmpty) {
                  return const Center(child: Text('Nicio clasă găsită.'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: classes.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final cls = classes[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(child: Text(cls.name[0])),
                        title: Text('Clasa ${cls.name}'),
                        subtitle: Text('ID: ${cls.id}'),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          // Aquí deberías navegar a la pantalla de detalle de notas
                          // pasándole cls.id como argumento.
                          Navigator.pushNamed(
                            context,
                            AppRoutes.teacherNotes + '/class/${cls.id}',
                            arguments: {'classroom_id': cls.id},
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
