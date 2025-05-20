// lib/screens/tutor/notes.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/widgets/scaffolds/tutor_scaffold.dart';
import 'package:attendio_mobile/services/tutor_service.dart';
import 'package:attendio_mobile/services/note_service.dart';
import 'package:attendio_mobile/models/user.dart';
import 'package:attendio_mobile/models/note.dart';
import 'package:attendio_mobile/routes.dart';

class TutorNotesScreen extends StatefulWidget {
  static const routeName = AppRoutes.tutorNotes;

  const TutorNotesScreen({super.key});

  @override
  _TutorNotesScreenState createState() => _TutorNotesScreenState();
}

class _TutorNotesScreenState extends State<TutorNotesScreen> {
  bool _loading = true;
  String? _error;

  List<User> _children = [];
  int _selectedChildIndex = 0;
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadChildrenAndNotes();
  }

  Future<void> _loadChildrenAndNotes() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      // 1️⃣ Cargo los hijos del tutor
      _children = await TutorService.getChildren();
      if (_children.isEmpty) {
        setState(() {
          _loading = false;
          _notes = [];
        });
        return;
      }
      // 2️⃣ Cargo las notas del primer hijo
      await _loadNotesForChild(_children[_selectedChildIndex].id);
    } catch (e) {
      setState(() => _error = 'Error cargando datos: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _loadNotesForChild(int studentId) async {
    try {
      final notes = await NoteService.getNotesByStudent(studentId);
      setState(() => _notes = notes);
    } catch (e) {
      setState(() => _error = 'Error al obtener notas: $e');
    }
  }

  double _calculateAverage(List<Note> notes) {
    if (notes.isEmpty) return 0;
    final sum = notes.map((n) => n.value).reduce((a, b) => a + b);
    return sum / notes.length;
  }

  /// Agrupa las notas por courseName
  Map<String, List<Note>> _groupByCourse(List<Note> notes) {
    final map = <String, List<Note>>{};
    for (var note in notes) {
      map.putIfAbsent(note.courseName, () => []).add(note);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return TutorScaffold(
      currentIndex: 1,
      notificationCount: 0,
      onNotificationTap: () => Navigator.pushNamed(context, AppRoutes.tutorNotifications),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : Column(
                  children: [
                    // Selector de hijo
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DropdownButtonFormField<int>(
                        value: _children.isNotEmpty ? _children[_selectedChildIndex].id : null,
                        decoration: const InputDecoration(
                          labelText: 'Selectați copilul',
                          border: OutlineInputBorder(),
                        ),
                        items: _children.map((child) {
                          return DropdownMenuItem<int>(
                            value: child.id,
                            child: Text(child.name),
                          );
                        }).toList(),
                        onChanged: (studentId) {
                          if (studentId == null) return;
                          final newIndex = _children.indexWhere((c) => c.id == studentId);
                          if (newIndex != -1) {
                            setState(() {
                              _selectedChildIndex = newIndex;
                              _loading = true;
                            });
                            _loadNotesForChild(studentId).whenComplete(() {
                              setState(() => _loading = false);
                            });
                          }
                        },
                      ),
                    ),

                    // Lista de notas por curso
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: _groupByCourse(_notes).entries.map((entry) {
                          final courseName = entry.key;
                          final courseNotes = entry.value;
                          final avg = _calculateAverage(courseNotes);

                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ExpansionTile(
                              title: Text(courseName),
                              subtitle: courseNotes.isEmpty
                                  ? const Text('Nu există note')
                                  : Text('Medie: ${avg.toStringAsFixed(2)}'),
                              children: courseNotes.map((note) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor.withOpacity(0.2),
                                    child: Text(
                                      note.value.toString(),
                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  title: Text(note.description ?? ''),
                                  subtitle: Text(
                                    note.date.toIso8601String().split('T').first,
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
    );
  }
}
