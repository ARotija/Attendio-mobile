// lib/screens/tutor/add_child.dart

import 'package:flutter/material.dart';
import 'package:attendio_mobile/routes.dart';
import 'package:attendio_mobile/services/tutor_service.dart';
import 'package:attendio_mobile/widgets/scaffolds/tutor_scaffold.dart';

class AddChildScreen extends StatefulWidget {
  static const routeName = AppRoutes.tutorAddChild;

  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final _codeController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleAddChild() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Introduceți codul studentului')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final success = await TutorService.addChild(code);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copilul a fost adăugat cu succes!')),
        );
        // Retornamos true para indicar éxito y refrescar en la pantalla anterior
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cod invalid sau copil deja adăugat'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Eroare: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TutorScaffold(
      currentIndex: 3,
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'ATTENDIO',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Adăugați copil',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              const Text(
                'Introduceți codul unic al studentului pentru a-l adăuga la contul dvs.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Cod student',
                  hintText: 'Ex: ST123456',
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _handleAddChild,
                  icon: const Icon(Icons.person_add),
                  label: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Adaugă copil'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
