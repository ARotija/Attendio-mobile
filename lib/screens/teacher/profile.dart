import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';

class TeacherProfileScreen extends StatelessWidget {
  static const routeName = '/teacher/profile';

  final Map<String, String> teacherData = {
    'Nombre': 'Carlos Mendoza',
    'Email': 'carlos.mendoza@colegio.edu',
    'Rol': 'Profesor',
    'Clase principal': '10B',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'teacher', currentRoute: TeacherProfileScreen.routeName),
      appBar: AppBar(title: Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...teacherData.entries.map((e) => ListTile(
              title: Text(e.key),
              subtitle: Text(e.value),
              leading: Icon(Icons.info_outline),
            )),
            Divider(),
            ElevatedButton.icon(
              onPressed: () {
                // Aquí podrías abrir un formulario o pantalla para cambiar contraseña
              },
              icon: Icon(Icons.lock),
              label: Text('Cambiar contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
