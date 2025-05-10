import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';
import '../../widgets/notification_bell.dart';
import 'notifications.dart';

class TutorAttendanceScreen extends StatefulWidget {
  static const routeName = '/tutor/attendance';

  @override
  _TutorAttendanceScreenState createState() => _TutorAttendanceScreenState();
}

class _TutorAttendanceScreenState extends State<TutorAttendanceScreen> {
  final List<String> children = ['Bocai Robert', 'Ana Maria'];

  // Dummy attendance stats per child per subject
  final Map<String, Map<String, Map<String, int>>> attendance = {
    'Bocai Robert': {
      'Matematica': {'present': 18, 'absent': 4},
      'Limba si Literatura Romana':       {'present': 20, 'absent': 2},
    },
    'Ana Maria': {
      'Istorie': {'present': 19, 'absent': 3},
      'Biologie': {'present': 21, 'absent': 1},
    },
  };

  int selectedChildIndex = 0;
  final int newNotificationsCount = 0;

  @override
  Widget build(BuildContext context) {
    String currentChild = children[selectedChildIndex];
    final childAttendance = attendance[currentChild]!;

    return Scaffold(
      drawer: SidebarDrawer(role: 'tutor', currentRoute: TutorAttendanceScreen.routeName),
      appBar: AppBar(
        title: Text('Absențe $currentChild'),
        actions: [
          NotificationBell(
            count: newNotificationsCount,
            onTap: () => Navigator.of(context).pushNamed(TutorNotificationsScreen.routeName),
          ),
        ],
      ),
      body: Column(
        children: [
          // Selector de hijo
          Padding(
            padding: EdgeInsets.all(16),
            child: DropdownButton<String>(
              value: currentChild,
              items: children
                  .map((n) => DropdownMenuItem(value: n, child: Text(n)))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    selectedChildIndex = children.indexOf(val);
                  });
                }
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: childAttendance.entries.map((e) {
                final subj = e.key;
                final p = e.value['present']!;
                final a = e.value['absent']!;
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(subj),
                    subtitle: Text('Prezențe: $p · Absențe: $a'),
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
    );
  }
}
