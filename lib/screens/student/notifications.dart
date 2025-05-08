import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';

class StudentNotificationsScreen extends StatelessWidget {
  static const routeName = '/student/notifications';

  // Dummy notifications list
  final List<Map<String, String>> notifications = [
    {
      'icon': 'close',
      'text': 'Has recibido una ausencia en Matemáticas el 02/05/2025 10:00'
    },
    {
      'icon': 'check',
      'text': 'Tu ausencia en Historia el 01/05/2025 fue motivada'
    },
    {
      'icon': 'star',
      'text': 'Has recibido nota 9 en Ciencias el 15/04/2025'
    },
  ];

  IconData iconFor(String key) {
    switch (key) {
      case 'check':
        return Icons.check_circle;
      case 'close':
        return Icons.cancel;
      case 'star':
        return Icons.star;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'student', currentRoute: routeName),
      appBar: AppBar(title: Text('Notificaciones')),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (_, i) {
          final n = notifications[i];
          return ListTile(
            leading: Icon(iconFor(n['icon']!)),
            title: Text(n['text']!),
          );
        },
      ),
    );
  }
}
