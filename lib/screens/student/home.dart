import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';
import '../../widgets/notification_bell.dart';
import 'notifications.dart';

class StudentHomeScreen extends StatelessWidget {
  static const routeName = '/student/home';

  // Dummy schedule for the logged‑in student
  final List<Map<String, String>> schedule = [
    {
      'day': 'Luni',
      'time': '08:00–09:00',
      'subject': 'Matematica',
      'room': '101'
    },
    {
      'day': 'Marti',
      'time': '09:00–10:00',
      'subject': 'Limba si Literatura Romana',
      'room': '102'
    },
  ];

  // simulate new notifications count
  final int newNotificationsCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'student', currentRoute: routeName),
      appBar: AppBar(
        title: Text('Horarul meu'),
        actions: [
          NotificationBell(
            count: newNotificationsCount,
            onTap: () =>
                Navigator.of(context).pushNamed(StudentNotificationsScreen.routeName),
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: schedule.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (_, i) {
          final e = schedule[i];
          return ListTile(
            leading: Icon(Icons.schedule),
            title: Text('${e['day']}  ${e['time']}'),
            subtitle: Text('${e['subject']} · Aula ${e['room']}'),
          );
        },
      ),
    );
  }
}
