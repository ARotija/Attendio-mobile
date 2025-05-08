import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';

class TutorNotificationsScreen extends StatelessWidget {
  static const routeName = '/tutor/notifications';

  // Dummy notifications
  final List<Map<String, String>> notifications = [
    {
      'child': 'María López',
      'icon': 'close',
      'text': 'Tu hija recibió una ausencia en Matemáticas el 02/05/2025 10:00'
    },
    {
      'child': 'Carlos Díaz',
      'icon': 'check',
      'text': 'La ausencia de tu hijo en Historia el 01/05/2025 fue motivada'
    },
  ];

  IconData iconFor(String key) {
    switch (key) {
      case 'check': return Icons.check_circle;
      case 'close': return Icons.cancel;
      default:      return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'tutor', currentRoute: routeName),
      appBar: AppBar(title: Text('Notificaciones Tutor')),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (_, i) {
          final n = notifications[i];
          return ListTile(
            leading: Icon(iconFor(n['icon']!)),
            title: Text(n['text']!),
            subtitle: Text(n['child']!),
          );
        },
      ),
    );
  }
}
