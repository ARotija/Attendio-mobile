// lib/screens/teacher/search.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/services/classroom_service.dart';
import '../../widgets/scaffolds/teacher_scaffold.dart';
import 'package:attendio_mobile/models/classroom.dart';

class TeacherSearchScreen extends StatefulWidget {
  static const routeName = '/teacher/search';

  @override
  _TeacherSearchScreenState createState() => _TeacherSearchScreenState();
}

class _TeacherSearchScreenState extends State<TeacherSearchScreen> {
  List<Classroom> _classes = [];
  String? selectedClass;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _classes = await ClassroomService.getClassrooms();
    } catch (e) {
      _error = 'Eroare la încărcarea sălilor: $e';
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 3,
      title: 'Căutare',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!))
                : Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedClass,
                        items: _classes.map((cls) {
                          // Usamos el nombre real de la classroom
                          return DropdownMenuItem(
                            value: cls.name,
                            child: Text(cls.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedClass = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Selectează sala',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: selectedClass == null
                            ? null
                            : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Căutare pentru: $selectedClass')),
                                );
                              },
                        icon: const Icon(Icons.search),
                        label: const Text('Caută'),
                      ),
                    ],
                  ),
      ),
    );
  }
}
