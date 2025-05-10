import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';
import '../../widgets/notification_bell.dart';
import 'notifications.dart';

class StudentAttendanceScreen extends StatelessWidget {
  static const routeName = '/student/attendance';

  // Dummy attendance stats per subject
  final Map<String, Map<String, int>> attendance = {
    'Matematica': { 'present': 20, 'absent': 2 },
    'Limba si Literatura Romana':       { 'present': 22, 'absent': 0 },
    'Biologie':     { 'present': 19, 'absent': 3 },
  };

  int get totalPresent =>
      attendance.values.map((e) => e['present']!).reduce((a, b) => a + b);
  int get totalAbsent =>
      attendance.values.map((e) => e['absent']!).reduce((a, b) => a + b);

  final int newNotificationsCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'student', currentRoute: routeName),
      appBar: AppBar(
        title: Text('Prezenta mea'),
        actions: [
          NotificationBell(
            count: newNotificationsCount,
            onTap: () =>
                Navigator.of(context).pushNamed(StudentNotificationsScreen.routeName),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Absente:', style: Theme.of(context).textTheme.titleMedium),
            Text('Prezent: $totalPresent'),
            Text('Absent:  $totalAbsent'),
            Divider(height: 32),
            Expanded(
              child: ListView(
                children: attendance.entries.map((e) {
                  final subj = e.key;
                  final p = e.value['present']!;
                  final a = e.value['absent']!;
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(subj),
                      subtitle: Text('Prezent: $p · Absent: $a'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, color: Colors.green),
                          SizedBox(width: 4),
                          Text('$p'),
                          SizedBox(width: 16),
                          Icon(Icons.close, color: Colors.red),
                          SizedBox(width: 4),
                          Text('$a'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
