import 'package:flutter/material.dart';
import 'package:attendio_mobile/theme.dart';
import 'package:attendio_mobile/services/auth_service.dart';

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

  Future<void> handleLogin() async {
    setState(() => isLoading = true);

    try {
      final role = await AuthService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      setState(() => isLoading = false);

      if (role != null) {
        if (role == 'teacher') {
          Navigator.pushReplacementNamed(context, '/teacher/home');
        } else if (role == 'student') {
          Navigator.pushReplacementNamed(context, '/student/home');
        } else if (role == 'tutor') {
          Navigator.pushReplacementNamed(context, '/tutor/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Rol invalid')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email sau parolă incorectă')),
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
              const Text('Autentificare',
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Adresă de email',
                  hintText: 'exemplu@gmail.com',
                ),
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
                      : const Text('Autentificare'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Navighează la ecranul de recuperare parolă (dacă este implementat)
                  Navigator.pushReplacementNamed(context, '/forgot-password');
                },
                child: const Text(
                  'Ai uitat parola?',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Intrare rapidă pentru profesor (test)
                  Navigator.pushReplacementNamed(context, '/teacher/home');
                },
                child: const Text(
                  'Fereastra profesor',
                  style: TextStyle(fontSize: 13, color: Colors.red),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Intrare rapidă pentru student (test)
                  Navigator.pushReplacementNamed(context, '/student/home');
                },
                child: const Text(
                  'Fereastra student',
                  style: TextStyle(fontSize: 13, color: Colors.red),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Intrare rapidă pentru tutor (test)
                  Navigator.pushReplacementNamed(context, '/tutor/home');
                },
                child: const Text(
                  'Fereastra tutor',
                  style: TextStyle(fontSize: 13, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
