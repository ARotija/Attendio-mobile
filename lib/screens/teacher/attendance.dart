import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  static const routeName = '/teacher/attendance';
  @override _TeacherAttendanceScreenState createState() => _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  String selectedClass = '9A';
  int selectedPeriod = 1;

  final classes = ['9A','10B','11C'];
  final periods = [1,2,3,4,5,6];

  // Dummy: quién está presente y ausente
  final present = ['Bocai Robert','Popescu Maria'];
  final absent  = ['Vasile Elena','Popescu Andrei'];

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'teacher', currentRoute: TeacherAttendanceScreen.routeName),
      appBar: AppBar(title: Text('Prezența elevilor')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Clasa'),
              value: selectedClass,
              items: classes.map((c)=>DropdownMenuItem(value:c,child:Text(c))).toList(),
              onChanged:(v)=> setState(()=>selectedClass=v!),
            )),
            SizedBox(width:16),
            Expanded(child: DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Perioada'),
              value: selectedPeriod,
              items: periods.map((p)=>DropdownMenuItem(value:p,child:Text('Ora $p'))).toList(),
              onChanged:(v)=> setState(()=>selectedPeriod=v!),
            )),
          ]),
          SizedBox(height:24),
          Expanded(
            child: ListView(
              children: [
                Text('Prezenți', style: Theme.of(ctx).textTheme.titleMedium),
                ...present.map((s)=>ListTile(
                  leading: Icon(Icons.check, color: Colors.green),
                  title: Text(s),
                )),
                Divider(),
                Text('Absenți', style: Theme.of(ctx).textTheme.titleMedium),
                ...absent.map((s)=>ListTile(
                  leading: Icon(Icons.close, color: Colors.red),
                  title: Text(s),
                )),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
