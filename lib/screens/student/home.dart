import 'package:flutter/material.dart';
import '../../widgets/scaffolds/student_scaffold.dart';
import 'notifications.dart';

class StudentHomeScreen extends StatelessWidget {
  static const routeName = '/student/home';

  final List<Map<String, String>> schedule = [
    {'day': 'Luni', 'time': '08:00–09:00', 'subject': 'Matematică', 'room': '101'},
    {'day': 'Marți', 'time': '09:00–10:00', 'subject': 'Limba Română', 'room': '102'},
    {'day': 'Miercuri', 'time': '10:00–11:00', 'subject': 'Fizică', 'room': '205'},
  ];

  final int notificationCount = 3;

  @override
  Widget build(BuildContext context) {
    return StudentScaffold(
      currentIndex: 0,
      notificationCount: notificationCount,
      onNotificationTap: () => Navigator.pushNamed(context, StudentNotificationsScreen.routeName),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Orarul tău săptămânal',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: schedule.length,
              separatorBuilder: (_, __) => Divider(height: 1),
              itemBuilder: (context, index) {
                final item = schedule[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text('${item['day']} ${item['time']}'),
                    subtitle: Text('${item['subject']} · Sala ${item['room']}'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}