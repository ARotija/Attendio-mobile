import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';

class TutorNotificationsScreen extends StatelessWidget {
  static const routeName = '/tutor/notifications';

  // Dummy notifications
  final List<Map<String, String>> notifications = [
    {
      'child': 'Ana María',
      'icon': 'close',
      'text': 'Copilul dumneavoastră a fost absent la ora de Matematică pe 05/02/2025, ora 10:10.'
    },
    {
      'child': 'Bocai Robert',
      'icon': 'check',
      'text': 'Absența copilului dumneavoastră de la Istorie pe 05.01.2025 a fost motivată'
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
      appBar: AppBar(title: Text('Notificări pentru tutori')),
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
