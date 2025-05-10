import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';

class StudentProfileScreen extends StatelessWidget {
  static const routeName = '/student/profile';

  // Dummy profile info
  final Map<String, String> profile = {
    'Nombre': 'Juan Hernández',
    'Email': 'juan.hernandez@colegio.edu',
    'Rol': 'Student',
    'Aula': '9A',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'student', currentRoute: routeName),
      appBar: AppBar(title: Text('Setarile mele')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ...profile.entries.map((e) => ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text(e.key),
                  subtitle: Text(e.value),
                )),
            Divider(),
            ElevatedButton.icon(
              icon: Icon(Icons.lock),
              label: Text('Schimba parola'),
              onPressed: () {
                // TODO: navegar a pantalla de cambio de contraseña
              },
            ),
          ],
        ),
      ),
    );
  }
}
