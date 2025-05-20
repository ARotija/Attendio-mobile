import 'package:flutter/material.dart';

class StudentNotificationsScreen extends StatelessWidget {
  static const routeName = '/student/notifications';

  final List<Map<String, dynamic>> notifications = const [
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
      case 'grade':
        return Icons.grade;
      case 'attendance':
        return Icons.assignment;
      case 'general':
        return Icons.announcement;
      default:
        return Icons.notifications;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'grade':
        return Colors.amber;
      case 'attendance':
        return Colors.red;
      case 'general':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificări'),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist),
            onPressed: () {
              // TODO: Marcar toate notificările ca citite
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final String type = notification['type'];
          final String title = notification['title'];
          final String message = notification['message'];
          final String time = notification['time'];
          final bool read = notification['read'];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: _getColorForType(type).withOpacity(0.2),
              child: Icon(
                _getIconForType(type),
                color: _getColorForType(type),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: read ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            trailing: !read
                ? const CircleAvatar(radius: 4, backgroundColor: Colors.red)
                : null,
            onTap: () {
              // TODO: Marcar ca citită și/sau deschide detalii
            },
          );
        },
      ),
    );
  }
}
