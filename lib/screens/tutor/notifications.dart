import 'package:flutter/material.dart';

class TutorNotificationsScreen extends StatelessWidget {
  static const routeName = '/tutor/notifications';

  final List<Map<String, dynamic>> notifications = [
    {
      'child': 'Ana Maria',
      'type': 'attendance',
      'title': 'Absență înregistrată',
      'message': 'La Matematică pe 05/02/2025',
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
      case 'grade':
        return Icons.grade;
      case 'attendance':
        return Icons.assignment_turned_in;
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
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificări'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            tooltip: 'Marchează toate ca citite',
            onPressed: () {
              // Aquí podrías implementar lógica para marcar como citadas
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Toate notificările au fost marcate ca citite')),
              );
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
          final isRead = notification['read'] as bool;

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
                    fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                Text(
                  notification['child'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['message']),
                const SizedBox(height: 4),
                Text(
                  notification['time'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            trailing: isRead
                ? null
                : const CircleAvatar(radius: 4, backgroundColor: Colors.red),
          );
        },
      ),
    );
  }
}
