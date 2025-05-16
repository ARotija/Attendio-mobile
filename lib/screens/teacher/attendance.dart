import 'package:flutter/material.dart';
import '../../widgets/scaffolds/teacher_scaffold.dart';

class TeacherAttendanceScreen extends StatelessWidget {
  static const routeName = '/teacher/attendance';

  final List<Map<String, dynamic>> attendanceRecords = [
    {'date': '2023-05-15', 'class': '9A', 'subject': 'Matematică', 'present': 22, 'absent': 2},
    {'date': '2023-05-14', 'class': '10B', 'subject': 'Fizică', 'present': 17, 'absent': 1},
    {'date': '2023-05-13', 'class': '11C', 'subject': 'Informatică', 'present': 19, 'absent': 1},
  ];

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 2,
      title: 'Prezențe',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Prezență nouă'),
                    onPressed: () {
                      // Crear nueva asistencia
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: attendanceRecords.length,
              itemBuilder: (context, index) {
                final record = attendanceRecords[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${record['date']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Chip(
                              label: Text('Clasa ${record['class']}'),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          record['subject'],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            AttendanceIndicator(
                              count: record['present'],
                              color: Colors.green,
                              label: 'Prezenți',
                            ),
                            SizedBox(width: 16),
                            AttendanceIndicator(
                              count: record['absent'],
                              color: Colors.red,
                              label: 'Absenți',
                            ),
                          ],
                        ),
                      ],
                    ),
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

class AttendanceIndicator extends StatelessWidget {
  final int count;
  final Color color;
  final String label;

  const AttendanceIndicator({
    required this.count,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Text(
            '$count',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}