import 'package:flutter/material.dart';
import '../../widgets/scaffolds/teacher_scaffold.dart';

class TeacherSearchScreen extends StatefulWidget {
  static const routeName = '/teacher/search';

  @override
  _TeacherSearchScreenState createState() => _TeacherSearchScreenState();
}

class _TeacherSearchScreenState extends State<TeacherSearchScreen> {
  final List<String> classes = ['Clasa a IX-a A', 'Clasa a X-a B', 'Clasa a XI-a C'];
  String? selectedClass;

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 3,
      title: 'Căutare',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedClass,
              items: classes.map((className) {
                return DropdownMenuItem(
                  value: className,
                  child: Text(className),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedClass = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Selectează clasa',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement search logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Căutare pentru: $selectedClass')),
                );
              },
              icon: Icon(Icons.search),
              label: Text('Caută'),
            ),
          ],
        ),
      ),
    );
  }
}
