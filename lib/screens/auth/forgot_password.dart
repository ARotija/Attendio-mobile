import 'package:flutter/material.dart';
import 'package:attendio_mobile/theme.dart';
import 'package:attendio_mobile/services/auth_service.dart';
import 'package:attendio_mobile/routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = AppRoutes.forgotPassword;

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  bool isLoading        = false;
  String? errorMessage;

  Future<void> handleForgotPassword() async {
    final email = emailController.text.trim();
    setState(() => errorMessage = null);

    // 1️⃣ Validación básica
    if (email.isEmpty) {
      setState(() => errorMessage = 'Te rog introdu adresa de email');
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() => errorMessage = 'Adresa de email nu este validă');
      return;
    }

    setState(() => isLoading = true);

    // 2️⃣ Llamada al servicio de request-reset
    final success = await AuthService.requestReset(email);

    setState(() => isLoading = false);

    if (success) {
      // Mostrar confirmación y volver al login
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dacă contul există, vei primi un email cu instrucțiuni.')),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } else {
      setState(() => errorMessage = 'Nu s-a putut trimite emailul. Încearcă din nou.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySwatch[400],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
              const Text('Recuperare parolă', style: TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 24),
              const Text(
                'Introdu adresa ta de email pentru a primi instrucțiuni de resetare.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 16),

              // Mostrar error
              if (errorMessage != null) ...[
                Text(errorMessage!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 12),
              ],

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Adresă de email',
                  hintText: 'exemplu@gmail.com',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : handleForgotPassword,
                  icon: isLoading 
                      ? const SizedBox.shrink() 
                      : const Icon(Icons.email),
                  label: isLoading
                      ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                      : const Text('Trimite email'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
