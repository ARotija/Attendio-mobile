// lib/screens/tutor/attendance.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/services/tutor_service.dart';
import 'package:attendio_mobile/services/attendance_service.dart';
import 'package:attendio_mobile/models/user.dart';
import 'package:attendio_mobile/models/attendance_record.dart';
import 'package:attendio_mobile/widgets/scaffolds/tutor_scaffold.dart';
import 'package:attendio_mobile/routes.dart';

class TutorAttendanceScreen extends StatefulWidget {
  static const routeName = AppRoutes.tutorAttendance;

  const TutorAttendanceScreen({super.key});

  @override
  _TutorAttendanceScreenState createState() => _TutorAttendanceScreenState();
}

class _TutorAttendanceScreenState extends State<TutorAttendanceScreen> {
  List<User> _children = [];
  User? _selectedChild;
  bool _loadingChildren = true;
  bool _loadingAttendance = false;
  List<AttendanceRecord> _records = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  Future<void> _loadChildren() async {
    setState(() {
      _loadingChildren = true;
      _error = null;
    });
    try {
      final kids = await TutorService.getChildren();
      setState(() {
        _children = kids;
        _selectedChild = kids.isNotEmpty ? kids.first : null;
      });
      if (_selectedChild != null) {
        await _loadAttendance(_selectedChild!);
      }
    } catch (e) {
      setState(() => _error = 'Error cargando lista de hijos: $e');
    } finally {
      setState(() => _loadingChildren = false);
    }
  }

  Future<void> _loadAttendance(User child) async {
    setState(() {
      _loadingAttendance = true;
      _error = null;
      _records = [];
    });
    try {
      // Obtener todos los registros del aula del alumno
      final recs = await AttendanceService.getRecords(
        classroomId: child.classroomId!,
        // opcional: filtrar periodo o fecha si lo deseas
      );
      // Filtrar solo los de este alumno
      setState(() {
        _records = recs.where((r) => r.userId == child.id).toList();
      });
    } catch (e) {
      setState(() => _error = 'Error cargando asistencias: $e');
    } finally {
      setState(() => _loadingAttendance = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TutorScaffold(
      currentIndex: 2,
      notificationCount: 0,
      onNotificationTap: () => Navigator.pushNamed(
        context,
        AppRoutes.tutorNotifications,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1) Selector de niño/a
            _loadingChildren
                ? const CircularProgressIndicator()
                : DropdownButtonFormField<User>(
                    value: _selectedChild,
                    items: _children
                        .map((u) => DropdownMenuItem(
                              value: u,
                              child: Text(u.name),
                            ))
                        .toList(),
                    decoration: const InputDecoration(
                      labelText: 'Selectați copilul',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (u) {
                      if (u != null) {
                        setState(() => _selectedChild = u);
                        _loadAttendance(u);
                      }
                    },
                  ),
            const SizedBox(height: 16),

            // 2) Carga de asistencias
            if (_loadingAttendance)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (_error != null)
              Expanded(child: Center(child: Text(_error!)))
            else if (_records.isEmpty)
              const Expanded(child: Center(child: Text('Nu există date de prezență.')))
            else
              // 3) Listado de registros
              Expanded(
                child: ListView.separated(
                  itemCount: _records.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, i) {
                    final rec = _records[i];
                    return ListTile(
                      title: Text(
                        '${rec.status == 'PRESENT' ? '✓' : '✗'} '
                        '${rec.date.toIso8601String().split('T').first}',
                      ),
                      subtitle: Text('Periodă: ${rec.period}'),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
