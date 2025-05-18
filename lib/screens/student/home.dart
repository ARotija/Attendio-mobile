import 'package:flutter/material.dart';
import '../../widgets/scaffolds/student_scaffold.dart';
import 'notifications.dart';

class StudentHomeScreen extends StatefulWidget {
  static const routeName = '/student/home';

  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  final List<Map<String, String>> schedule = [
    {'day': 'Luni', 'time': '08:00–09:00', 'subject': 'Matematică', 'room': '101'},
    {'day': 'Luni', 'time': '09:00–10:00', 'subject': 'Biologie', 'room': '103'},
    {'day': 'Marți', 'time': '09:00–10:00', 'subject': 'Limba Română', 'room': '102'},
    {'day': 'Marți', 'time': '10:00–11:00', 'subject': 'Istorie', 'room': '104'},
    {'day': 'Miercuri', 'time': '10:00–11:00', 'subject': 'Fizică', 'room': '205'},
  ];

  final int notificationCount = 3;

  // Grupez materia după zi
  Map<String, List<Map<String, String>>> get groupedSchedule {
    final Map<String, List<Map<String, String>>> map = {};
    for (var item in schedule) {
      final day = item['day']!;
      if (!map.containsKey(day)) {
        map[day] = [];
      }
      map[day]!.add(item);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = groupedSchedule;
    final days = grouped.keys.toList();

    return StudentScaffold(
      currentIndex: 0,
      notificationCount: notificationCount,
      onNotificationTap: () =>
          Navigator.pushNamed(context, StudentNotificationsScreen.routeName),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'Orarul tău săptămânal',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 16),
          ...days.map((day) {
            final daySchedule = grouped[day]!;
            return ExpansionTile(
              title: Text(day),
              children: daySchedule.map((item) {
                return ListTile(
                  title: Text('${item['time']} - ${item['subject']}'),
                  subtitle: Text('Sala ${item['room']}'),
                  leading: Icon(Icons.schedule),
                );
              }).toList(),
            );
          }).toList(),
        ],
      ),
    );
  }
}
