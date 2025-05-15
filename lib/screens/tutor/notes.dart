import 'package:flutter/material.dart';
import '../../widgets/scaffolds/tutor_scaffold.dart';
import 'notifications.dart';

class TutorNotesScreen extends StatefulWidget {
  static const routeName = '/tutor/notes';

  @override
  _TutorNotesScreenState createState() => _TutorNotesScreenState();
}

class _TutorNotesScreenState extends State<TutorNotesScreen> {
  final List<String> children = ['Bocai Robert', 'Ana Maria'];
  int selectedChildIndex = 0;

  final Map<String, Map<String, List<Map<String, dynamic>>>> notesData = {
    'Bocai Robert': {
      'Matematica': [
        {'grade': 7, 'date': '02/05/2025', 'type': 'Test'},
        {'grade': 8, 'date': '15/04/2025', 'type': 'Tema'},
      ],
      'Limba Română': [],
    },
    'Ana Maria': {
      'Istorie': [
        {'grade': 9, 'date': '01/05/2025', 'type': 'Proiect'},
      ],
      'Biologie': [],
    },
  };

  final int notificationCount = 1;

  double _calculateAverage(List<Map<String, dynamic>> grades) {
    if (grades.isEmpty) return 0;
    return grades.map((g) => g['grade'] as int).reduce((a, b) => a + b) / grades.length;
  }

  @override
  Widget build(BuildContext context) {
    final currentChild = children[selectedChildIndex];
    final childNotes = notesData[currentChild]!;

    return TutorScaffold(
      currentIndex: 1,
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
              children: childNotes.entries.map((subjectEntry) {
                final subject = subjectEntry.key;
                final notes = subjectEntry.value;
                final average = _calculateAverage(notes);
                
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: ExpansionTile(
                    title: Text(subject),
                    subtitle: notes.isEmpty 
                        ? Text('Nu există note')
                        : Text('Medie: ${average.toStringAsFixed(2)}'),
                    children: notes.map((note) => ListTile(
                      leading: CircleAvatar(
                        child: Text(note['grade'].toString()),
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                      title: Text(note['type']),
                      subtitle: Text(note['date']),
                    )).toList(),
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