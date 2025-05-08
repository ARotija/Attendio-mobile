import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';
import '../../widgets/notification_bell.dart';
import 'notifications.dart';

class TutorNotesScreen extends StatefulWidget {
  static const routeName = '/tutor/notes';

  // Dummy children list
  final List<String> children = ['María López', 'Carlos Díaz'];

  // Dummy notes per child per subject
  final Map<String, Map<String, List<Map<String, String>>>> notes = {
    'María López': {
      'Matemáticas': [
        {'value': '7', 'date': '02/05/2025'},
        {'value': '8', 'date': '15/04/2025'},
      ],
      'Lengua': [],
    },
    'Carlos Díaz': {
      'Historia': [
        {'value': '9', 'date': '01/05/2025'},
      ],
      'Ciencias': [],
    },
  };

  final int newNotificationsCount = 1;

  @override
  _TutorNotesScreenState createState() => _TutorNotesScreenState();
}

class _TutorNotesScreenState extends State<TutorNotesScreen> {
  int selectedChildIndex = 0;

  @override
  Widget build(BuildContext context) {
    String currentChild = widget.children[selectedChildIndex];
    final childNotes = widget.notes[currentChild]!;

    double average(List<Map<String, String>> list) {
      if (list.isEmpty) return 0.0;
      return list.map((e) => double.parse(e['value']!)).reduce((a, b) => a + b) / list.length;
    }

    return Scaffold(
      drawer: SidebarDrawer(role: 'tutor', currentRoute: TutorNotesScreen.routeName),
      appBar: AppBar(
        title: Text('Notas de $currentChild'),
        actions: [
          NotificationBell(
            count: widget.newNotificationsCount,
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
              items: widget.children
                  .map((name) => DropdownMenuItem(value: name, child: Text(name)))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    selectedChildIndex = widget.children.indexOf(val);
                  });
                }
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: childNotes.entries.map((entry) {
                final subject = entry.key;
                final list = entry.value;
                final avg = average(list);
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(subject),
                    subtitle: list.isEmpty
                        ? Text('Sin notas')
                        : Wrap(
                            spacing: 6,
                            children: list
                                .map((n) => Chip(label: Text('${n['value']} (${n['date']})')))
                                .toList(),
                          ),
                    trailing: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: avg > 0 ? Theme.of(context).colorScheme.secondary : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        avg > 0 ? avg.toStringAsFixed(1) : '-',
                        style: TextStyle(color: Colors.white),
                      ),
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
