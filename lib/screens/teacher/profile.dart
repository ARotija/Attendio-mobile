// lib/screens/teacher/profile.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/widgets/scaffolds/teacher_scaffold.dart';
import 'package:attendio_mobile/services/user_service.dart';
import 'package:attendio_mobile/services/auth_service.dart';
import 'package:attendio_mobile/routes.dart';
import 'package:attendio_mobile/models/user.dart';

class TeacherProfileScreen extends StatefulWidget {
  static const routeName = AppRoutes.teacherProfile;

  const TeacherProfileScreen({super.key});

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  late Future<User> _futureMe;

  @override
  void initState() {
    super.initState();
    _futureMe = UserService.getMe();
  }

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 4,
      body: FutureBuilder<User>(
        future: _futureMe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Eroare la încărcare: ${snapshot.error}'));
          }
          final user = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    // Puedes cambiar a una URL por defecto según role, aquí un placeholder
                    'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                  ),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  user.role.name,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    child: Column(
                      children: [
                        _buildTile(Icons.email, 'Email', user.email),
                        // Si tuvieras teléfono u otros, agrégalos aquí
                        // _buildTile(Icons.phone, 'Telefon', user.phone ?? '–'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.settings),
                        label: const Text('Schimbă parola'),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.forgotPassword);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.logout),
                        label: const Text('Deconectare'),
                        onPressed: () async {
                          await AuthService.logout();
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          foregroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }

  ListTile _buildTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
