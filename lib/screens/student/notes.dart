// lib/screens/student/notes.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/services/note_service.dart';
import 'package:attendio_mobile/models/note.dart';
import 'package:attendio_mobile/widgets/scaffolds/student_scaffold.dart';
import 'package:attendio_mobile/routes.dart';
import 'package:attendio_mobile/services/storage_service.dart';

class StudentNotesScreen extends StatefulWidget {
  static const routeName = AppRoutes.studentNotes;

  const StudentNotesScreen({super.key});

  @override
  _StudentNotesScreenState createState() => _StudentNotesScreenState();
}

class _StudentNotesScreenState extends State<StudentNotesScreen> {
  bool _loading = true;
  String? _error;
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // Recuperar user_id de SharedPreferences
      final userId = await StorageService.getUserId();
      if (userId == null) throw Exception('User ID not found');

      // Obtener notas del alumno
      final notes = await NoteService.getNotesByStudent(userId);
      setState(() => _notes = notes);
    } catch (e) {
      setState(() => _error = 'Error cargando notas: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  double _calculateAverage(List<Note> notes) {
    if (notes.isEmpty) return 0;
    final sum = notes.map((n) => n.value).reduce((a, b) => a + b);
    return sum / notes.length;
  }

  @override
  Widget build(BuildContext context) {
    return StudentScaffold(
      currentIndex: 1,
      notificationCount: 0,
      onNotificationTap: () =>
          Navigator.pushNamed(context, AppRoutes.studentNotifications),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : (_error != null
              ? Center(child: Text(_error!))
              : _notes.isEmpty
                  ? const Center(child: Text('Nu ai note înregistrate.'))
                  : ListView(
                      children: _groupBySubject(_notes).entries.map((entry) {
                        final subject = entry.key;
                        final grades = entry.value;
                        final avg = _calculateAverage(grades);
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ExpansionTile(
                            title: Text(subject),
                            subtitle: grades.isEmpty
                                ? const Text('Nu ai note înregistrate')
                                : Text('Medie: ${avg.toStringAsFixed(2)}'),
                            children: grades.map((note) {
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(note.value.toString()),
                                ),
                                title: Text(note.description ?? 'Sin descripción'),
                                subtitle: Text(
                                  note.date
                                      .toIso8601String()
                                      .split('T')
                                      .first,
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    )),
    );
  }

  /// Agrupa la lista de notas por materia
  Map<String, List<Note>> _groupBySubject(List<Note> notes) {
    final Map<String, List<Note>> map = {};
    for (var note in notes) {
      map.putIfAbsent(note.courseName, () => []).add(note);
    }
    return map;
  }
}
