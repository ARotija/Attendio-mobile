import 'package:flutter/material.dart';
import 'package:attendio_mobile/theme.dart';
import 'package:attendio_mobile/services/auth_service.dart';
import 'package:attendio_mobile/services/storage_service.dart';
import 'package:attendio_mobile/routes.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = AppRoutes.login;

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController    = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading           = false;
  String? errorMessage;

  Future<void> handleLogin() async {
    final email    = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() => errorMessage = null);

    // 1️⃣ Validaciones locales
    if (email.isEmpty || password.isEmpty) {
      setState(() => errorMessage = 'Te rog completează toate câmpurile');
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() => errorMessage = 'Adresa de email nu este validă');
      return;
    }

    setState(() => isLoading = true);

    // 2️⃣ Llamada al servicio de autenticación (login + GET /users/me)
    final success = await AuthService.login(email, password);
    setState(() => isLoading = false);

    if (!success) {
      setState(() => errorMessage = 'Email sau parolă incorectă');
      return;
    }

    // 3️⃣ Recuperar rol desde StorageService (guardado tras GET /users/me)
    final role = await StorageService.getRole();
    if (role == null) {
      setState(() => errorMessage = 'Eroare la citirea rolului utilizatorului');
      return;
    }

    // 4️⃣ Navegar según rol
    switch (role.toUpperCase()) {
      case 'TEACHER':
        Navigator.pushReplacementNamed(context, AppRoutes.teacherHome);
        break;
      case 'STUDENT':
        Navigator.pushReplacementNamed(context, AppRoutes.studentHome);
        break;
      case 'TUTOR':
        Navigator.pushReplacementNamed(context, AppRoutes.tutorHome);
        break;
      default:
        setState(() => errorMessage = 'Rol invalid: $role');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySwatch[400],
      body: Center(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'ATTENDIO',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1.5),
              ),
              const SizedBox(height: 8),
              const Text('Autentificare', style: TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 16),

              // Mensaje de error
              if (errorMessage != null) ...[
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
              ],

              // Email
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Adresă de email',
                  hintText: 'exemplu@gmail.com',
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
              const SizedBox(height: 24),

              // Botón de login
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: isLoading ? null : handleLogin,
                  child: isLoading
                      ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                      : const Text('Autentificare'),
                ),
              ),

              const SizedBox(height: 16),

              // Enlaces secundarios
              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
                child: const Text('Ai uitat parola?', style: TextStyle(fontSize: 13)),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                child: const Text('Înregistrează-te', style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
