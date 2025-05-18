import 'package:flutter/material.dart';
import '../../widgets/scaffolds/tutor_scaffold.dart';
import 'notifications.dart';

class TutorProfileScreen extends StatelessWidget {
  static const routeName = '/tutor/profile';

  final Map<String, String> profile = {
    'Nume': 'Olivia Marinescu',
    'Email': 'olivia.marinescu@example.com',
    'Telefon': '+40 721 123 456',
    'Copii înregistrați': '2',
  };

  final int notificationCount = 0;

  @override
  Widget build(BuildContext context) {
    return TutorScaffold(
      currentIndex: 3,
      notificationCount: notificationCount,
      onNotificationTap: () => Navigator.pushNamed(context, TutorNotificationsScreen.routeName),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/43.jpg'),
            ),
            SizedBox(height: 16),
            Text(
              profile['Nume']!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Tutor',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Column(
                  children: profile.entries.map((entry) => ListTile(
                    leading: Icon(_getIconForField(entry.key)),
                    title: Text(entry.key),
                    subtitle: Text(entry.value),
                  )).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton.icon(
                icon: Icon(Icons.group_add),
                label: Text('Adăugați copil'),
                onPressed: () {
                  Navigator.pushNamed(context, '/tutor/add-child');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Schimbă parola'),
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot-password');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: OutlinedButton.icon(
                icon: Icon(Icons.logout),
                label: Text('Deconectare'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  foregroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForField(String field) {
    switch (field) {
      case 'Nume': return Icons.person;
      case 'Email': return Icons.email;
      case 'Telefon': return Icons.phone;
      case 'Copii înregistrați': return Icons.child_care;
      default: return Icons.info;
    }
  }
}