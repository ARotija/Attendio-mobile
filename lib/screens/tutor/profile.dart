import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';

class TutorProfileScreen extends StatelessWidget {
  static const routeName = '/tutor/profile';

  final Map<String, String> profile = {
    'Nombre': 'Olivia Marinescu',
    'Email': 'olivia.marinescu.com',
    'Rol': 'Tutor',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'tutor', currentRoute: routeName),
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
              icon: Icon(Icons.group_add),
              label: Text('Adăugați copii'),
              onPressed: () {
                // TODO: navegar a pantalla de agregar hijos
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.lock),
              label: Text('Schimbaţi parola'),
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
