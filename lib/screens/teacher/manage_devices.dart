import 'package:flutter/material.dart';
import 'package:attendio_mobile/services/device_service.dart';
import 'package:attendio_mobile/models/device.dart';
import 'package:attendio_mobile/routes.dart';
import '../../widgets/scaffolds/teacher_scaffold.dart';

class ManageDevicesScreen extends StatefulWidget {
  static const routeName = AppRoutes.teacherManageDevices;

  const ManageDevicesScreen({super.key});

  @override
  _ManageDevicesScreenState createState() => _ManageDevicesScreenState();
}

class _ManageDevicesScreenState extends State<ManageDevicesScreen> {
  late final int userId;
  late final String userName;
  late Future<List<Device>> _futureDevices;
  final _deviceController = TextEditingController();
  bool _loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userId = args['userId'] as int;
    userName = args['userName'] as String;
    _loadDevices();
  }

  void _loadDevices() {
    _futureDevices = DeviceService.listDevices(userId);
  }

  Future<void> _addDevice() async {
    final id = _deviceController.text.trim();
    if (id.isEmpty) return;
    setState(() => _loading = true);
    try {
      await DeviceService.addDevice(userId: userId, deviceId: id);
      _deviceController.clear();
      _loadDevices();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al añadir: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _removeDevice(String deviceId) async {
    setState(() => _loading = true);
    try {
      await DeviceService.removeDevice(userId: userId, deviceId: deviceId);
      _loadDevices();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _deviceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 4, // Igual que en la lista
      title: 'Disp. de $userName',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Lista de dispositivos
            Expanded(
              child: FutureBuilder<List<Device>>(
                future: _futureDevices,
                builder: (ctx, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snap.hasError) {
                    return Center(child: Text('Error: ${snap.error}'));
                  }
                  final list = snap.data!;
                  if (list.isEmpty) {
                    return const Center(child: Text('No hay dispositivos asignados.'));
                  }
                  return ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (ctx, i) {
                      final d = list[i];
                      return ListTile(
                        title: Text(d.id),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeDevice(d.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Formulario para añadir uno nuevo
            TextField(
              controller: _deviceController,
              decoration: const InputDecoration(
                labelText: 'ID dispositivo (MAC/UUID)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _loading ? null : _addDevice,
                icon: const Icon(Icons.add),
                label: _loading 
                  ? const SizedBox(
                      width: 16, height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Asignar dispositivo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
