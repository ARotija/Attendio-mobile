import 'package:flutter/material.dart';
import '../../widgets/scaffolds/tutor_scaffold.dart';

class TutorNotificationsScreen extends StatelessWidget {
  static const routeName = '/tutor/notifications';

  final List<Map<String, dynamic>> notifications = [
    {
      'child': 'Ana Maria',
      'type': 'attendance',
      'title': 'Absență înregistrată',
      'message': 'La Matematica pe 05/02/2025',
      'time': 'Acum 2 ore',
      'read': false,
    },
    {
      'child': 'Bocai Robert',
      'type': 'grade',
      'title': 'Notă nouă',
      'message': '8 la Istorie - Test',
      'time': 'Ieri',
      'read': true,
    },
  ];

  IconData _getIconForType(String type) {
    switch (type) {
      case 'grade': return Icons.grade;
      case 'attendance': return Icons.assignment;
      default: return Icons.notifications;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'grade': return Colors.amber;
      case 'attendance': return Colors.red;
      default: return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificări'),
        actions: [
          IconButton(
            icon: Icon(Icons.checklist),
            onPressed: () {
              // Marcar todas como leídas
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: _getColorForType(notification['type']).withOpacity(0.2),
              child: Icon(
                _getIconForType(notification['type']),
                color: _getColorForType(notification['type']),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['title'],
                  style: TextStyle(
                    fontWeight: notification['read'] ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                Text(
                  notification['child'],
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['message']),
                SizedBox(height: 4),
                Text(
                  notification['time'],
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            trailing: !notification['read'] 
                ? CircleAvatar(radius: 4, backgroundColor: Colors.red)
                : null,
          );
        },
      ),
    );
  }
}