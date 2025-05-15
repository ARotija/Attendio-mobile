import 'package:flutter/material.dart';
import '../../widgets/scaffolds/student_scaffold.dart';
import 'notifications.dart';

class StudentAttendanceScreen extends StatelessWidget {
  static const routeName = '/student/attendance';

  // Datos de ejemplo: ausencias por materia
  final Map<String, List<Map<String, dynamic>>> absenceData = {
    'Matematică': [
      {'date': '2023-05-10', 'motivated': true},
      {'date': '2023-05-17', 'motivated': false},
    ],
    'Limba Română': [], // Sin ausencias
    'Fizică': [
      {'date': '2023-04-15', 'motivated': false},
      {'date': '2023-04-22', 'motivated': false},
      {'date': '2023-05-05', 'motivated': true},
    ],
    'Informatică': [
      {'date': '2023-03-10', 'motivated': true},
    ],
  };

  // Calcular totales
  int get totalMotivated => absenceData.values
      .expand((absences) => absences)
      .where((a) => a['motivated'] == true)
      .length;

  int get totalUnmotivated => absenceData.values
      .expand((absences) => absences)
      .where((a) => a['motivated'] == false)
      .length;

  final int notificationCount = 1;

  @override
  Widget build(BuildContext context) {
    return StudentScaffold(
      currentIndex: 2,
      notificationCount: notificationCount,
      onNotificationTap: () => Navigator.pushNamed(context, StudentNotificationsScreen.routeName),
      body: Column(
        children: [
          // Resumen de ausencias
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Total absențe',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAbsenceCounter('Motivate', totalMotivated, Colors.green),
                        _buildAbsenceCounter('Nemotivate', totalUnmotivated, Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Lista de ausencias por materia
          Expanded(
            child: ListView(
              children: absenceData.entries.map((subject) {
                final subjectName = subject.key;
                final absences = subject.value;
                
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subjectName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        
                        if (absences.isEmpty)
                          Text(
                            'Fără absențe',
                            style: TextStyle(color: Colors.grey),
                          )
                        else
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: absences.map((absence) {
                              return Chip(
                                label: Text(
                                  absence['date'],
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: absence['motivated'] 
                                    ? Colors.green 
                                    : Colors.red,
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: absence['motivated']
                                        ? Colors.green.shade800
                                        : Colors.red.shade800,
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

  Widget _buildAbsenceCounter(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}