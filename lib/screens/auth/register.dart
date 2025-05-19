import 'package:flutter/material.dart';
import 'package:attendio_mobile/theme.dart';
import 'package:attendio_mobile/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? selectedRole;
  String? selectedClass; // Nou
  bool isLoading = false;

  final List<String> classOptions = [ // Nou
    'Clasa a IX-a',
    'Clasa a X-a',
    'Clasa a XI-a',
    'Clasa a XII-a',
  ];

  Future<void> handleRegister() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adresa de email nu este validă')),
      );
      return;
    }

    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Te rugăm să selectezi un rol')),
      );
      return;
    }

    if (selectedRole == 'student' && selectedClass == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Te rugăm să selectezi o clasă')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Parolele nu coincid')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Trimite și clasa, dacă e student
      final success = await AuthService.register(
        email,
        password,
        selectedRole!, // Poți trimite selectedClass ca parametru suplimentar dacă e nevoie
      );

      setState(() => isLoading = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Înregistrare reușită, te rugăm să te autentifici')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Eroare la înregistrarea utilizatorului')),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Eroare: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySwatch[400],
      body: Stack(
        children: [
          Center(
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
              child: SingleChildScrollView(
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
                      'Crează cont',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 24),

                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: const InputDecoration(
                        labelText: 'Selectează un rol',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'student',
                          child: Text('Student'),
                        ),
                        DropdownMenuItem(
                          value: 'tutor',
                          child: Text('Tutor'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value;
                          selectedClass = null; // Resetăm dacă se schimbă rolul
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    if (selectedRole == 'student') // Afișăm doar dacă e student
                      Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: selectedClass,
                            decoration: const InputDecoration(
                              labelText: 'Selectează clasa',
                            ),
                            items: classOptions.map((clasa) {
                              return DropdownMenuItem(
                                value: clasa,
                                child: Text(clasa),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedClass = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),

                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Adresa de email',
                        hintText: 'nume@exemplu.com',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Parolă',
                        hintText: '********',
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirmă parola',
                        hintText: '********',
                      ),
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : handleRegister,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : const Text('Înregistrează utilizator'),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
