import 'package:flutter/material.dart';
import '../../widgets/scaffolds/student_scaffold.dart';
import 'notifications.dart';

class StudentNotesScreen extends StatelessWidget {
  static const routeName = '/student/notes';

  final Map<String, List<Map<String, dynamic>>> subjects = {
    'Matematică': [
      {'grade': 9, 'date': '15.05.2023', 'type': 'Test'},
      {'grade': 8, 'date': '01.05.2023', 'type': 'Lucrare practică'},
    ],
    'Limba Română': [
      {'grade': 10, 'date': '10.05.2023', 'type': 'Compoziție'},
    ],
    'Fizică': [],
  };

  final int notificationCount = 2;

  double _calculateAverage(List<Map<String, dynamic>> grades) {
    if (grades.isEmpty) return 0;
    return grades.map((g) => g['grade'] as int).reduce((a, b) => a + b) / grades.length;
  }

  @override
  Widget build(BuildContext context) {
    return StudentScaffold(
      currentIndex: 1,
      notificationCount: notificationCount,
      onNotificationTap: () => Navigator.pushNamed(context, StudentNotificationsScreen.routeName),
      body: ListView(
        children: subjects.entries.map((entry) {
          final subject = entry.key;
          final grades = entry.value;
          final average = _calculateAverage(grades);
          
          return Card(
            margin: EdgeInsets.all(8),
            child: ExpansionTile(
              title: Text(subject),
              subtitle: grades.isEmpty 
                  ? Text('Nu ai note înregistrate')
                  : Text('Medie: ${average.toStringAsFixed(2)}'),
              children: grades.map((grade) => ListTile(
                leading: CircleAvatar(
                  child: Text(grade['grade'].toString()),
                ),
                title: Text(grade['type']),
                subtitle: Text(grade['date']),
              )).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}