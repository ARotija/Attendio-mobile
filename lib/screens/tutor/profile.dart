// lib/screens/tutor/profile.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/widgets/scaffolds/tutor_scaffold.dart';
import 'package:attendio_mobile/services/user_service.dart';
import 'package:attendio_mobile/services/tutor_service.dart';
import 'package:attendio_mobile/services/auth_service.dart';
import 'package:attendio_mobile/routes.dart';
import 'package:attendio_mobile/models/user.dart';

class TutorProfileScreen extends StatefulWidget {
  static const routeName = AppRoutes.tutorProfile;

  const TutorProfileScreen({super.key});

  @override
  State<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
  late Future<_ProfileData> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _loadProfileData();
  }

  Future<_ProfileData> _loadProfileData() async {
    final user = await UserService.getMe();
    final children = await TutorService.getChildren();
    return _ProfileData(user: user, childCount: children.length);
  }

  @override
  Widget build(BuildContext context) {
    return TutorScaffold(
      currentIndex: 3,
      body: FutureBuilder<_ProfileData>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Eroare la încărcare: ${snapshot.error}'));
          }
          final data = snapshot.data!;
          final user = data.user;
          final count = data.childCount;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    // placeholder image
                    'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?fit=crop&w=512&h=512',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tutor',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    child: Column(
                      children: [
                        _buildTile(Icons.email, 'Email', user.email),
                        // Si tu backend incluye teléfono, agrégalo:
                        // _buildTile(Icons.phone, 'Telefon', user.phone ?? '–'),
                        _buildTile(Icons.child_care, 'Copii înregistrați', '$count'),
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
                        icon: const Icon(Icons.group_add),
                        label: const Text('Adăugați copil'),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.tutorAddChild);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                      OutlinedButton.icon(
                        icon: const Icon(Icons.logout),
                        label: const Text('Deconectare'),
                        onPressed: () async {
                          await AuthService.logout();
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
                        },
                        style: OutlinedButton.styleFrom(
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

/// Aux class to hold both user and child count
class _ProfileData {
  final User user;
  final int childCount;
  _ProfileData({required this.user, required this.childCount});
}
