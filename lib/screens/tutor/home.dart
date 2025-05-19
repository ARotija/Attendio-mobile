import 'package:flutter/material.dart';
import 'package:attendio_mobile/widgets/scaffolds/tutor_scaffold.dart';
import 'package:attendio_mobile/routes.dart';

class TutorHomeScreen extends StatelessWidget {
  static const routeName = '/tutor/home';

  final List<Map<String, String>> childrenSchedule = [
    {
      'child': 'Bocai Robert',
      'day': 'Luni',
      'time': '08:00–09:00',
      'subject': 'Matematică',
      'room': '101'
    },
    {
      'child': 'Ana Maria',
      'day': 'Marți',
      'time': '09:00–10:00',
      'subject': 'Limba Română',
      'room': '102'
    },
  ];

  final int notificationCount = 2;

  @override
  Widget build(BuildContext context) {
    return TutorScaffold(
      currentIndex: 0,
      notificationCount: notificationCount,
      onNotificationTap: () => Navigator.pushNamed(context, AppRoutes.tutorNotifications),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: childrenSchedule.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final schedule = childrenSchedule[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(schedule['child']!.substring(0, 1)),
              ),
              title: Text(schedule['child']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${schedule['day']} ${schedule['time']}'),
                  Text('${schedule['subject']} · Sala ${schedule['room']}'),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
