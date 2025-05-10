import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';

class TeacherHomeScreen extends StatelessWidget {
  static const routeName = '/teacher/home';

  // Datos de ejemplo: horario
  final List<Map<String,String>> schedule = [
    { 'day': 'Luni', 'time': '08:00–09:00', 'class': '9A', 'room': '102' },
    { 'day': 'Luni', 'time': '09:00–10:00', 'class': '10B', 'room': '204' },
    { 'day': 'Marți','time': '10:00–11:00','class': '11C','room': '301' },
  ];

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'teacher', currentRoute: routeName),
      appBar: AppBar(title: Text('Programul meu')),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: schedule.length,
        separatorBuilder: (_,__)=>Divider(),
        itemBuilder: (c,i) {
          final e = schedule[i];
          return ListTile(
            leading: Icon(Icons.schedule),
            title: Text('${e['day']} ${e['time']}'),
            subtitle: Text('Clasa ${e['class']} · Sala ${e['room']}'),
          );
        },
      ),
    );
  }
}
