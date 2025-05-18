import 'package:flutter/material.dart';
import '../../widgets/scaffolds/student_scaffold.dart';
import 'notifications.dart';

class StudentProfileScreen extends StatelessWidget {
  static const routeName = '/student/profile';

  final Map<String, String> userData = {
    'Nume': 'Ionescu Maria',
    'Clasă': '9A',
    'Școală': 'Liceul Teoretic "Mihai Eminescu"',
    'Email': 'maria.ionescu@liceu.ro',
    'Cod student': 'ST123456',
  };

  final int notificationCount = 0;

  @override
  Widget build(BuildContext context) {
    return StudentScaffold(
      currentIndex: 3,
      notificationCount: notificationCount,
      onNotificationTap: () => Navigator.pushNamed(context, StudentNotificationsScreen.routeName),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/4140/4140046.png'), // para mujer -->  https://cdn-icons-png.flaticon.com/512/4140/4140061.png
            backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 16),
            Text(
              userData['Nume']!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Elev - ${userData['Clasă']}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Column(
                  children: userData.entries.map((entry) {
                    return ListTile(
                      leading: Icon(_getIconForField(entry.key)),
                      title: Text(entry.key),
                      subtitle: Text(entry.value),
                    );
                  }).toList(),
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
      case 'Clasă': return Icons.school;
      case 'Școală': return Icons.account_balance;
      case 'Email': return Icons.email;
      case 'Cod student': return Icons.badge;
      default: return Icons.info;
    }
  }
}
