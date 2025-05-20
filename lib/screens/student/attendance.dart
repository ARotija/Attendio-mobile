// lib/screens/student/attendance.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/services/user_service.dart';
import 'package:attendio_mobile/services/attendance_service.dart';
import 'package:attendio_mobile/models/attendance_record.dart';
import 'package:attendio_mobile/widgets/scaffolds/student_scaffold.dart';
import 'package:attendio_mobile/routes.dart';

class StudentAttendanceScreen extends StatefulWidget {
  static const routeName = AppRoutes.studentAttendance;

  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  late Future<List<AttendanceRecord>> _futureAbsences;

  @override
  void initState() {
    super.initState();
    _futureAbsences = _loadAbsences();
  }

  Future<List<AttendanceRecord>> _loadAbsences() async {
    // 1️⃣ Primero, obtén el perfil para tener classroom_id
    final me = await UserService.getMe();
    final classroomId = me.classroomId;
    // 2️⃣ Luego, pide todos los registros de asistencia
    final allRecords = await AttendanceService.getRecords(
      classroomId: classroomId,
      // opcional: period: null, date: null
    );
    // 3️⃣ Filtra solo los ausentes
    return allRecords.where((r) => r.status == 'ABSENT').toList();
  }

  @override
  Widget build(BuildContext context) {
    return StudentScaffold(
      currentIndex: 2,
      notificationCount: 0,
      onNotificationTap: () => Navigator.pushNamed(
          context, AppRoutes.studentNotifications),
      body: FutureBuilder<List<AttendanceRecord>>(
        future: _futureAbsences,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Eroare: ${snapshot.error}'));
          }
          final absences = snapshot.data!;
          if (absences.isEmpty) {
            return const Center(child: Text('Nu există absențe.'));
          }
          // 4️⃣ Renderiza la lista de absențe
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: absences.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, i) {
              final rec = absences[i];
              return ListTile(
                leading: const Icon(Icons.event_busy, color: Colors.red),
                title: Text(
                  rec.date.toIso8601String().split('T').first,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Perioada ${rec.period}'),
                trailing: const Text(
                  'Absent',
                  style: TextStyle(color: Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
