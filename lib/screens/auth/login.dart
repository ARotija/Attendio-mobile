import 'package:flutter/material.dart';
import 'package:attendio_mobile/theme.dart';
import 'package:attendio_mobile/services/auth_service.dart';
import 'package:attendio_mobile/services/user_service.dart';     // <-- NUEVO
import 'package:attendio_mobile/models/user.dart';               // <-- NUEVO

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  // Manejo del login
  Future<void> handleLogin() async {
    setState(() => isLoading = true);

    try {
      // 1) Intentar hacer login y guardar tokens
      final success = await AuthService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (!success) {
        // Si falla el login, mostramos mensaje
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email o contraseña incorrectos')),
        );
        return;
      }

      // 2) Login exitoso: obtener perfil para saber el rol
      final User me = await UserService.getMe();   // <-- NUEVO
      setState(() => isLoading = false);

      // 3) Redirigir según el rol
      switch (me.role.name.toLowerCase()) {
        case 'teacher':
          Navigator.pushReplacementNamed(context, '/teacher/home');
          break;
        case 'student':
          Navigator.pushReplacementNamed(context, '/student/home');
          break;
        case 'tutor':
          Navigator.pushReplacementNamed(context, '/tutor/home');
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Rol no válido')),
          );
      }
    } catch (e) {
      // Cualquier otro error
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
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
              const Text('ATTENDIO',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 1.5)),
              const SizedBox(height: 8),
              const Text('Iniciar sesión',
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  hintText: 'name@gmail.com',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  hintText: '********',
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: isLoading ? null : handleLogin,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white))
                      : const Text('Iniciar sesión'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // TODO: navegar a pantalla de recuperación de contraseña
                },
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/student/home');
                },
                child: const Text(
                  'Ventana estudiante (demo)',
                  style: TextStyle(fontSize: 13, color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
