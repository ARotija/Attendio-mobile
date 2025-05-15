import 'package:flutter/material.dart';
import '../../widgets/scaffolds/teacher_scaffold.dart';

class TeacherHomeScreen extends StatelessWidget {
  static const routeName = '/teacher/home';

  final List<Map<String, String>> schedule = [
    {'day': 'Luni', 'time': '08:00–09:00', 'class': '9A', 'room': '102', 'subject': 'Matematică'},
    {'day': 'Luni', 'time': '09:00–10:00', 'class': '10B', 'room': '204', 'subject': 'Fizică'},
    {'day': 'Marți', 'time': '10:00–11:00', 'class': '11C', 'room': '301', 'subject': 'Informatică'},
    {'day': 'Marți', 'time': '11:00–12:00', 'class': '12D', 'room': '105', 'subject': 'Matematică'},
  ];

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 0,
      title: 'Programul meu',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Orarul săptămânii',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: schedule.length,
              separatorBuilder: (_, __) => Divider(height: 1),
              itemBuilder: (context, index) {
                final item = schedule[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.schedule, size: 20),
                  ),
                  title: Text('${item['day']} ${item['time']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item['subject']} - Clasa ${item['class']}'),
                      Text('Sala ${item['room']}'),
                    ],
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Navegar a detalles de la clase
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}