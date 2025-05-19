// lib/screens/student/profile.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/widgets/scaffolds/student_scaffold.dart';
import 'package:attendio_mobile/services/user_service.dart';
import 'package:attendio_mobile/services/device_service.dart';
import 'package:attendio_mobile/services/auth_service.dart';
import 'package:attendio_mobile/models/user.dart';
import 'package:attendio_mobile/models/device.dart';
import 'package:attendio_mobile/routes.dart';

class StudentProfileScreen extends StatefulWidget {
  static const routeName = AppRoutes.studentProfile;

  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  late Future<User> _futureUser;
  late Future<List<Device>> _futureDevices;

  @override
  void initState() {
    super.initState();
    _futureUser = UserService.getMe();
    _futureDevices = _futureUser.then((user) => DeviceService.listDevices(user.id));
  }

  @override
  Widget build(BuildContext context) {
    return StudentScaffold(
      currentIndex: 3,
      notificationCount: 0,
      onNotificationTap: () => Navigator.pushNamed(
        context, AppRoutes.studentNotifications),
      body: FutureBuilder<User>(
        future: _futureUser,
        builder: (context, userSnap) {
          if (userSnap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (userSnap.hasError) {
            return Center(child: Text('Error: ${userSnap.error}'));
          }
          final user = userSnap.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/4140/4140046.png'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 16),
                Text(user.name, style: Theme.of(context).textTheme.headlineSmall),
                Text('Elev - ${user.classroomName ?? "–"}',
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),

                // Datos del usuario
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email'),
                          subtitle: Text(user.email),
                        ),
                        ListTile(
                          leading: const Icon(Icons.badge),
                          title: const Text('Cod student'),
                          subtitle: Text(user.studentCode ?? '–'),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Dispositivos BLE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FutureBuilder<List<Device>>(
                    future: _futureDevices,
                    builder: (context, devSnap) {
                      if (devSnap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (devSnap.hasError) {
                        return Center(child: Text('Error: ${devSnap.error}'));
                      }
                      final devices = devSnap.data!;
                      return Card(
                        child: ExpansionTile(
                          title: const Text('Dispozitive asociate'),
                          children: devices.map((d) {
                            return ListTile(
                              leading: const Icon(Icons.bluetooth),
                              title: Text(d.id),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await DeviceService.removeDevice(
                                    userId: user.id,
                                    deviceId: d.id,
                                  );
                                  setState(() {
                                    _futureDevices =
                                        DeviceService.listDevices(user.id);
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Botones
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.settings),
                    label: const Text('Schimbă parola'),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.forgotPassword);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: OutlinedButton.icon(
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
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
