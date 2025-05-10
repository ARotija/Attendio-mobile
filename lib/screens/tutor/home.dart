import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';
import '../../widgets/notification_bell.dart';
import 'notifications.dart';

class TutorHomeScreen extends StatelessWidget {
  static const routeName = '/tutor/home';

  // Dummy schedule for tutor’s children
  final List<Map<String, String>> schedule = [
    {
      'child': 'Bocai Robert',
      'day': 'Luni',
      'time': '08:00–09:00',
      'subject': 'Matematica',
      'room': '101'
    },
    {
      'child': 'Ana Maria',
      'day': 'Marți',
      'time': '09:00–10:00',
      'subject': 'Limba si Literatura Romana',
      'room': '102'
    },
  ];

  final int newNotificationsCount = 2;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'tutor', currentRoute: routeName),
      appBar: AppBar(
        title: Text('Horarul copiilor'),
        actions: [
          NotificationBell(
            count: newNotificationsCount,
            onTap: () => Navigator.of(ctx).pushNamed(TutorNotificationsScreen.routeName),
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
            title: Text('${e['child']}  •  ${e['day']} ${e['time']}'),
            subtitle: Text('${e['subject']} · Sala ${e['room']}'),
          );
        },
      ),
    );
  }
}
