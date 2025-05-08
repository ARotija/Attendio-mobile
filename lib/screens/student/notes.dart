import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';
import '../../widgets/notification_bell.dart';
import 'notifications.dart';

class StudentNotesScreen extends StatelessWidget {
  static const routeName = '/student/notes';

  // Dummy notes per subject
  final Map<String, List<Map<String, String>>> notes = {
    'Matemáticas': [
      {'value': '8', 'date': '01/05/2025'},
      {'value': '9', 'date': '15/04/2025'},
    ],
    'Lengua': [],
    'Ciencias': [
      {'value': '7', 'date': '20/03/2025'},
    ],
  };

  int get totalMotivated => 0; // (no aplica aquí)
  int get totalUnmotivated => 0;

  double average(List<Map<String, String>> list) {
    if (list.isEmpty) return 0.0;
    return list.map((e) => double.parse(e['value']!)).reduce((a, b) => a + b) / list.length;
  }

  final int newNotificationsCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'student', currentRoute: routeName),
      appBar: AppBar(
        title: Text('Mis Notas'),
        actions: [
          NotificationBell(
            count: newNotificationsCount,
            onTap: () =>
                Navigator.of(context).pushNamed(StudentNotificationsScreen.routeName),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: notes.entries.map((entry) {
          final subject = entry.key;
          final list = entry.value;
          final avg = average(list);
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(subject),
              subtitle: list.isEmpty
                  ? Text('Sin notas')
                  : Wrap(
                      spacing: 6,
                      children: list
                          .map((n) => Chip(label: Text('${n['value']} (${n['date']})')))
                          .toList(),
                    ),
              trailing: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: avg > 0 ? Theme.of(context).colorScheme.secondary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  avg > 0 ? avg.toStringAsFixed(1) : '-',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
