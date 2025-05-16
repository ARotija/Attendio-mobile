import 'package:flutter/material.dart';
import '../../widgets/scaffolds/teacher_scaffold.dart';

class TeacherNotesScreen extends StatelessWidget {
  static const routeName = '/teacher/notes';

  final List<Map<String, dynamic>> classes = [
    {'class': '9A', 'subject': 'Matematică', 'students': 24},
    {'class': '10B', 'subject': 'Fizică', 'students': 18},
    {'class': '11C', 'subject': 'Informatică', 'students': 20},
  ];

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 1,
      title: 'Note elevilor',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Caută clasă sau elev...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final cls = classes[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(cls['class']),
                    ),
                    title: Text('Clasa ${cls['class']} - ${cls['subject']}'),
                    subtitle: Text('${cls['students']} elevi'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navegar a lista de elevi pentru notare
                    },
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