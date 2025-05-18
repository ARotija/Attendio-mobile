// lib/screens/tutor/add_child_screen.dart
import 'package:flutter/material.dart';

class AddChildScreen extends StatefulWidget {
  static const routeName = '/tutor/add-child';

  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final classController = TextEditingController();

  bool isLoading = false;

  void handleAddChild() {
    // Simulează salvarea copilului
    setState(() => isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copilul a fost adăugat cu succes!')),
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adăugați copil'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nume copil',
                  hintText: 'Ex: Andrei Popescu',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email copil',
                  hintText: 'Ex: andrei@email.com',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: classController,
                decoration: const InputDecoration(
                  labelText: 'Clasa',
                  hintText: 'Ex: a VI-a B',
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : handleAddChild,
                  icon: const Icon(Icons.check),
                  label: isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text('Adaugă copil'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
