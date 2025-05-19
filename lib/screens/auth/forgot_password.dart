import 'package:flutter/material.dart';
import 'package:attendio_mobile/services/auth_service.dart';
import 'package:attendio_mobile/theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  Future<void> handleForgotPassword() async {
    final email = emailController.text.trim();
    setState(() {
      errorMessage = null;
    });

    if (email.isEmpty) {
      setState(() {
        errorMessage = 'Te rog introdu adresa de email';
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
      final success = await AuthService.forgotPassword(email);

      setState(() => isLoading = false);

      if (success) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Succes'),
            content: const Text('Email trimis pentru resetarea parolei.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        ).then((_) => Navigator.pop(context));
      } else {
        setState(() {
          errorMessage = 'Nu s-a putut trimite emailul, încearcă din nou';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushReplacementNamed('/login');
            }
          },
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
                'Recuperare parolă',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              const Text(
                'Introdu adresa ta de email pentru a primi instrucțiuni de resetare.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 24),
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
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : handleForgotPassword,
                  icon: const Icon(Icons.email),
                  label: isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
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
