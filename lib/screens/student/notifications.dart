import 'package:flutter/material.dart';
import '../../widgets/scaffolds/student_scaffold.dart'; // se puede borrar

class StudentNotificationsScreen extends StatelessWidget {
  static const routeName = '/student/notifications';

  final List<Map<String, dynamic>> notifications = [
    {
      'type': 'grade',
      'title': 'Ai primit o notă nouă',
      'message': '9 la Matematică - Test semestrial',
      'time': 'Acum 2 ore',
      'read': false,
    },
    {
      'type': 'attendance',
      'title': 'Absență înregistrată',
      'message': 'La Fizică pe 15.05.2023',
      'time': 'Ieri',
      'read': true,
    },
    {
      'type': 'general',
      'title': 'Întâlnire părinți',
      'message': 'Vineri, 19.05.2023, ora 18:00',
      'time': 'Acum 3 zile',
      'read': true,
    },
  ];

  IconData _getIconForType(String type) {
    switch (type) {
      case 'grade': return Icons.grade;
      case 'attendance': return Icons.assignment;
      case 'general': return Icons.announcement;
      default: return Icons.notifications;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'grade': return Colors.amber;
      case 'attendance': return Colors.red;
      case 'general': return Colors.blue;
      default: return Colors.grey;
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
            title: Text(
              notification['title'],
              style: TextStyle(
                fontWeight: notification['read'] ? FontWeight.normal : FontWeight.bold,
              ),
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
            onTap: () {
              // Marcar como leída y mostrar detalles
            },
          );
        },
      ),
    );
  }
}