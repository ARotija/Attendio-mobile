import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';

class TeacherNotesScreen extends StatefulWidget {
  static const routeName = '/teacher/notes';
  @override _TeacherNotesScreenState createState() => _TeacherNotesScreenState();
}

class _TeacherNotesScreenState extends State<TeacherNotesScreen> {
  String selectedClass = '9A';
  String selectedStudent = 'Bocai Robert';

  // Datos dummy
  final classes = ['9A','10B','11C'];
  final students = ['Bocai Robert','Popescu Maria','Vasile Elena','Popescu Andrei'];
  final Map<String,List<String>> notesBySubject = {
    'Matematica': [],
    'Istorie': ['7 (01/05)','9 (15/04)'],
    'Biologie': ['8 (20/03)'],
  };

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'teacher', currentRoute: TeacherNotesScreen.routeName),
      appBar: AppBar(title: Text('Note')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(children: [
              Expanded(child: DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Clasa'),
                value: selectedClass,
                items: classes.map((c)=>DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v){ setState(()=> selectedClass = v!); },
              )),
              SizedBox(width: 16),
              Expanded(child: DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Elev'),
                // Aquí se puede usar un FutureBuilder para cargar los alumnos de la clase seleccionada
                value: selectedStudent,
                items: students.map((s)=>DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (v){ setState(()=> selectedStudent = v!); },
              )),
            ]),
            SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: notesBySubject.entries.map((entry){
                  return ListTile(
                    title: Text(entry.key),
                    subtitle: entry.value.isEmpty
                      ? Text('Fără note')
                      : Wrap(
                          spacing: 8,
                          children: entry.value.map((n)=>Chip(label: Text(n))).toList(),
                        ),
                    trailing: Icon(Icons.edit),
                    onTap: () {
                      // Aquí muestra modal para agregar/eliminar
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
