import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';

class TeacherNotesScreen extends StatefulWidget {
  static const routeName = '/teacher/notes';
  @override _TeacherNotesScreenState createState() => _TeacherNotesScreenState();
}

class _TeacherNotesScreenState extends State<TeacherNotesScreen> {
  String selectedClass = '9A';
  String selectedStudent = 'Juan Pérez';

  // Datos dummy
  final classes = ['9A','10B','11C'];
  final students = ['Juan Pérez','Ana García','Luis Martínez'];
  final Map<String,List<String>> notesBySubject = {
    'Matemáticas': [],
    'Historia': ['7 (01/05)','9 (15/04)'],
    'Ciencias': ['8 (20/03)'],
  };

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'teacher', currentRoute: TeacherNotesScreen.routeName),
      appBar: AppBar(title: Text('Notas')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(children: [
              Expanded(child: DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Clase'),
                value: selectedClass,
                items: classes.map((c)=>DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v){ setState(()=> selectedClass = v!); },
              )),
              SizedBox(width: 16),
              Expanded(child: DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Alumno'),
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
                      ? Text('Sin notas')
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
