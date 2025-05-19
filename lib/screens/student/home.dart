// lib/screens/student/home.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/widgets/scaffolds/student_scaffold.dart';
import 'package:attendio_mobile/routes.dart';

class StudentHomeScreen extends StatefulWidget {
  static const routeName = AppRoutes.studentHome;

  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  // Datos de ejemplo; luego podrías cargarlos via API si los provees
  final List<Map<String, String>> schedule = [
    {'day': 'Luni',   'time': '08:00–09:00', 'subject': 'Matematică',      'room': '101'},
    {'day': 'Luni',   'time': '09:00–10:00', 'subject': 'Biologie',         'room': '103'},
    {'day': 'Marți',  'time': '09:00–10:00', 'subject': 'Limba Română',     'room': '102'},
    {'day': 'Marți',  'time': '10:00–11:00', 'subject': 'Istorie',          'room': '104'},
    {'day': 'Miercuri','time': '10:00–11:00','subject': 'Fizică',           'room': '205'},
  ];

  // Ejemplo de contador de notificaciones
  final int notificationCount = 3;

  // Agrupa el horario por día
  Map<String, List<Map<String, String>>> get groupedSchedule {
    final Map<String, List<Map<String, String>>> map = {};
    for (var item in schedule) {
      final day = item['day']!;
      map.putIfAbsent(day, () => []).add(item);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = groupedSchedule;
    final days = grouped.keys.toList();

    return StudentScaffold(
      currentIndex: 0,
      notificationCount: notificationCount,
      onNotificationTap: () =>
          Navigator.pushNamed(context, AppRoutes.studentNotifications),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Orarul tău săptămânal',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          // Genera un ExpansionTile por cada día
          for (var day in days) ...[
            ExpansionTile(
              title: Text(day),
              children: [
                for (var item in grouped[day]!) ListTile(
                  leading: const Icon(Icons.schedule),
                  title: Text('${item['time']} – ${item['subject']}'),
                  subtitle: Text('Sala ${item['room']}'),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
