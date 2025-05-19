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
  String? errorMessage;

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      errorMessage = null;
    });

    // Validare câmpuri
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Te rog completează toate câmpurile';
      });
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        errorMessage = 'Adresa de email nu este validă';
      });
      return;
    }

    setState(() => isLoading = true);

    try {
      final role = await AuthService.login(email, password);
      setState(() => isLoading = false);

      if (role != null) {
        if (role == 'teacher') {
          Navigator.pushReplacementNamed(context, '/teacher/home');
        } else if (role == 'student') {
          Navigator.pushReplacementNamed(context, '/student/home');
        } else if (role == 'tutor') {
          Navigator.pushReplacementNamed(context, '/tutor/home');
        } else {
          setState(() {
            errorMessage = 'Rol invalid';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Email sau parolă incorectă';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Eroare: ${e.toString()}';
      });
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
              const SizedBox(height: 16),

              // Mesaj de eroare
              if (errorMessage != null) ...[
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
              ],

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
                  Navigator.pushNamed(context, '/forgot-password');
                },
                child: const Text(
                  'Ai uitat parola?',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
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
