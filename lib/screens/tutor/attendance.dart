import 'package:flutter/material.dart';
import '../../widgets/scaffolds/tutor_scaffold.dart';
import 'notifications.dart';

class TutorAttendanceScreen extends StatefulWidget {
  static const routeName = '/tutor/attendance';

  @override
  _TutorAttendanceScreenState createState() => _TutorAttendanceScreenState();
}

class _TutorAttendanceScreenState extends State<TutorAttendanceScreen> {
  final List<String> children = ['Bocai Robert', 'Ana Maria'];
  int selectedChildIndex = 0;

  final Map<String, Map<String, Map<String, int>>> attendanceData = {
    'Bocai Robert': {
      'Matematica': {'present': 18, 'absent': 4},
      'Limba Română': {'present': 20, 'absent': 2},
    },
    'Ana Maria': {
      'Istorie': {'present': 19, 'absent': 3},
      'Biologie': {'present': 21, 'absent': 1},
    },
  };

  final int notificationCount = 0;

  @override
  Widget build(BuildContext context) {
    final currentChild = children[selectedChildIndex];
    final childAttendance = attendanceData[currentChild]!;

    return TutorScaffold(
      currentIndex: 2,
      notificationCount: notificationCount,
      onNotificationTap: () => Navigator.pushNamed(context, TutorNotificationsScreen.routeName),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: currentChild,
              items: children.map((name) => 
                DropdownMenuItem(value: name, child: Text(name))
              ).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedChildIndex = children.indexOf(value);
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Selectați copilul',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: childAttendance.entries.map((subjectEntry) {
                final subject = subjectEntry.key;
                final stats = subjectEntry.value;
                final total = stats['present']! + stats['absent']!;
                final percentage = stats['present']! / total;
                
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: percentage,
                          backgroundColor: Colors.red[100],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Prezențe: ${stats['present']}'),
                            Text('Absențe: ${stats['absent']}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}