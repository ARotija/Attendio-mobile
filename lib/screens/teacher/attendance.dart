// lib/screens/teacher/attendance.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/widgets/scaffolds/teacher_scaffold.dart';
import 'package:attendio_mobile/services/attendance_service.dart';
import 'package:attendio_mobile/models/attendance_record.dart';
import 'package:attendio_mobile/routes.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  static const routeName = AppRoutes.teacherAttendance;

  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() => _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  late final int classroomId;
  int selectedPeriod = 1;
  DateTime selectedDate = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    classroomId = args != null && args['classroom_id'] != null
        ? args['classroom_id'] as int
        : 0;
  }

  Future<List<AttendanceRecord>> _loadRecords() {
      // Convertimos la fecha a "YYYY-MM-DD"
      final dateStr = selectedDate.toIso8601String().split('T').first;
      return AttendanceService.getRecords(
        classroomId: classroomId,
        period: selectedPeriod,
        date: dateStr,
      );
  }

  Future<void> _onScanPressed() async {
    // Navegar a la pantalla de escaneo pasando los mismos parámetros
    Navigator.pushNamed(
      context,
      AppRoutes.teacherScan,
      arguments: {
        'classroom_id': classroomId,
        'period': selectedPeriod,
      },
    ).then((_) {
      // Al volver del scan, recarga los registros
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 2,
      title: 'Prezențe',
      body: Column(
        children: [
          // Filtros: fecha y periodo, y botón de nuevo scan
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Selector de periodo
                DropdownButton<int>(
                  value: selectedPeriod,
                  items: List.generate(
                    6,
                    (i) => DropdownMenuItem(
                      value: i + 1,
                      child: Text('Perioada ${i + 1}'),
                    ),
                  ),
                  onChanged: (val) {
                    if (val != null) setState(() => selectedPeriod = val);
                  },
                ),
                const Spacer(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.fingerprint),
                  label: const Text('Scan nou'),
                  onPressed: _onScanPressed,
                ),
              ],
            ),
          ),

          // Lista de registros
          Expanded(
            child: FutureBuilder<List<AttendanceRecord>>(
              future: _loadRecords(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Eroare: ${snapshot.error}'));
                }
                final records = snapshot.data!;
                if (records.isEmpty) {
                  return const Center(child: Text('Nu există date de prezență.'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: records.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, i) {
                    final rec = records[i];
                    return ListTile(
                      title: Text('User #${rec.userId}'),
                      subtitle: Text(
                        '${rec.status} — ${rec.date.toIso8601String().split("T").first}',
                      ),
                      trailing: Text(
                        rec.status == AttendanceStatus.present ? '✓' : '✗',
                        style: TextStyle(
                          color: rec.status == AttendanceStatus.present
                              ? Colors.green
                              : Colors.red,
                          fontSize: 18,
                        ),
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
