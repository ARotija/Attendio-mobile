import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../services/attendance_service.dart';
import '../../widgets/scaffolds/teacher_scaffold.dart';
import '../../models/attendance_record.dart';

class TeacherScanScreen extends StatefulWidget {
  static const routeName = AppRoutes.teacherScan;

  const TeacherScanScreen({super.key});

  @override
  State<TeacherScanScreen> createState() => _TeacherScanScreenState();
}

class _TeacherScanScreenState extends State<TeacherScanScreen> {
  int? selectedClassroomId;
  int? selectedPeriod;
  bool isLoading = false;
  List<AttendanceRecord> scannedRecords = [];

  final List<Map<String, dynamic>> classrooms = [
    {'id': 1, 'name': '9A'},
    {'id': 2, 'name': '10B'},
    {'id': 3, 'name': '11C'},
  ];

  final List<int> periods = [1, 2, 3, 4, 5];

  Future<void> _scan() async {
    if (selectedClassroomId == null || selectedPeriod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selectează clasa și ora')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // En una app real esto vendría de escaneo Bluetooth, QR, etc.
      final fakeDeviceIds = ['device1', 'device2', 'device3'];

      final results = await AttendanceService.scanAttendance(
        classroomId: selectedClassroomId!,
        period: selectedPeriod!,
        deviceIds: fakeDeviceIds,
      );

      setState(() {
        scannedRecords = results;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Eroare: ${e.toString()}')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 2,
      title: 'Scanare prezență',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'Clasă'),
                    value: selectedClassroomId,
                    items: classrooms
                        .map((c) => DropdownMenuItem<int>(
                              value: c['id'],
                              child: Text(c['name']),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => selectedClassroomId = value),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'Ora'),
                    value: selectedPeriod,
                    items: periods
                        .map((p) => DropdownMenuItem<int>(
                              value: p,
                              child: Text('Ora $p'),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => selectedPeriod = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scanează prezența'),
              onPressed: isLoading ? null : _scan,
            ),
            const SizedBox(height: 24),
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading && scannedRecords.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemCount: scannedRecords.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final record = scannedRecords[index];
                    return ListTile(
                      title: Text('User ID: ${record.userId}'),
                      subtitle: Text('Status: ${record.statusEnum.name.toUpperCase()}'),
                      trailing: Text(record.timestamp
                        .toIso8601String()
                        .split('T')
                        .first),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
