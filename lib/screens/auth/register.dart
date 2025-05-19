import 'package:flutter/material.dart';
import 'package:attendio_mobile/theme.dart';
import 'package:attendio_mobile/services/auth_service.dart';
import 'package:attendio_mobile/routes.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = AppRoutes.register;

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController               = TextEditingController();
  final emailController              = TextEditingController();
  final passwordController           = TextEditingController();
  final confirmPasswordController    = TextEditingController();

  String? selectedRole;
  bool isLoading = false;
  String? errorMessage;

  Future<void> handleRegister() async {
    setState(() => errorMessage = null);

    final name    = nameController.text.trim();
    final email   = emailController.text.trim();
    final pass    = passwordController.text;
    final confirm = confirmPasswordController.text;

    // 1️⃣ Validaciones locales
    if (name.isEmpty || email.isEmpty || pass.isEmpty || confirm.isEmpty || selectedRole == null) {
      setState(() => errorMessage = 'Completează toate câmpurile, te rog.');
      return;
    }
    if (name.length < 2) {
      setState(() => errorMessage = 'Numele trebuie să aibă cel puțin 2 caractere.');
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() => errorMessage = 'Adresa de email nu este validă.');
      return;
    }
    if (pass.length < 6) {
      setState(() => errorMessage = 'Parola trebuie să aibă cel puțin 6 caractere.');
      return;
    }
    if (pass != confirm) {
      setState(() => errorMessage = 'Parolele nu coincid.');
      return;
    }

    setState(() => isLoading = true);

    // 2️⃣ Llamada al servicio de registro
    // Convertimos el rol a roleId: STUDENT -> 1, TUTOR -> 3, etc. 
    // Ajusta estos IDs según tu base de datos.
    int roleId;
    switch (selectedRole) {
      case 'student':
        roleId = 1;
        break;
      case 'tutor':
        roleId = 3;
        break;
      default:
        roleId = 1;
    }

    final success = await AuthService.register(
      name: name,
      email: email,
      password: pass,
      roleId: roleId,
    );

    setState(() => isLoading = false);

    if (success) {
      // Registro OK: notificar y volver al login
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Înregistrare reușită! Te rugăm să te autentifici.')),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } else {
      setState(() => errorMessage = 'Eroare la înregistrarea utilizatorului.');
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
                  BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'ATTENDIO',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1.5),
                    ),
                    const SizedBox(height: 8),
                    const Text('Crează cont', style: TextStyle(fontSize: 16, color: Colors.black54)),
                    const SizedBox(height: 16),

                    // Mostrar error
                    if (errorMessage != null) ...[
                      Text(errorMessage!, style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 12),
                    ],

                    // Nombre
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nume complet',
                        hintText: 'Ion Popescu',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Email
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Adresă de email',
                        hintText: 'nume@exemplu.com',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Contraseña
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Parolă',
                        hintText: '********',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Confirmar contraseña
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirmă parola',
                        hintText: '********',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Selección de rol
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: const InputDecoration(labelText: 'Selectează un rol'),
                      items: const [
                        DropdownMenuItem(value: 'student', child: Text('Student')),
                        DropdownMenuItem(value: 'tutor', child: Text('Tutor')),
                      ],
                      onChanged: (value) => setState(() => selectedRole = value),
                    ),
                    const SizedBox(height: 24),

                    // Botón de registro
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : handleRegister,
                        child: isLoading
                            ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                            : const Text('Înregistrează utilizator'),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          // Botón de volver
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
