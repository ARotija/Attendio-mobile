import 'package:flutter/material.dart';
import '../../widgets/scaffolds/teacher_scaffold.dart';

class TeacherProfileScreen extends StatelessWidget {
  static const routeName = '/teacher/profile';

  final Map<String, String> userData = {
    'Nume': 'Ionescu Maria',
    'Materie predată': 'Matematică',
    'Școală': 'Liceul Teoretic "Mihai Eminescu"',
    'Email': 'maria.ionescu@liceu.ro',
    'Telefon': '0741234567',
    'Cod student': 'ST123456',
  };

  final int notificationCount = 0;

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 4,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 16),
            Text(
              userData['Nume']!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
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
              child: Column(
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Inregistrează elev/tutor legal'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: Icon(Icons.settings),
                    label: Text('Schimbă parola'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
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
      case 'Nume':
        return Icons.person;
      case 'Materie predată':
        return Icons.book;
      case 'Școală':
        return Icons.account_balance;
      case 'Email':
        return Icons.email;
      case 'Cod student':
        return Icons.badge;
      case 'Telefon':
        return Icons.phone;
      default:
        return Icons.info;
    }
  }
}
