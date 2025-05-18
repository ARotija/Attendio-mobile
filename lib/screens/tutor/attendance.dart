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

  final Map<String, Map<String, List<Map<String, dynamic>>>> attendanceData = {
    'Bocai Robert': {
      'Matematica': [
        {'date': '2024-10-10', 'motivated': false},
        {'date': '2024-10-15', 'motivated': true},
      ],
      'Limba Română': [
        {'date': '2024-10-12', 'motivated': false},
      ],
    },
    'Ana Maria': {
      'Istorie': [
        {'date': '2024-10-14', 'motivated': true},
        {'date': '2024-10-20', 'motivated': false},
      ],
      'Biologie': [],
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
              children: childAttendance.entries.map((entry) {
                final subject = entry.key;
                final absences = entry.value;

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
                        SizedBox(height: 12),
                        if (absences.isEmpty)
                          Text(
                            'Nicio absență.',
                            style: TextStyle(color: Colors.green),
                          )
                        else
                          Column(
                            children: absences.map((absence) {
                              final isMotivated = absence['motivated'] as bool;
                              final date = absence['date'];
                              return ListTile(
                                leading: Icon(Icons.event,
                                    color: isMotivated ? Colors.green : Colors.red),
                                title: Text('Data: $date'),
                                subtitle: Text(
                                  isMotivated ? 'Absență motivată' : 'Absență nemotivată',
                                  style: TextStyle(
                                    color: isMotivated ? Colors.green : Colors.red,
                                  ),
                                ),
                              );
                            }).toList(),
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