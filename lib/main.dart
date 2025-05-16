import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'theme.dart';
import 'routes.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar variables de entorno desde .env
  await dotenv.load(fileName: ".env");

  // Verificar si hay token guardado (sesión activa)
  final token = await AuthService.getAccessToken();

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({required this.isLoggedIn, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendio',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialRoute: isLoggedIn ? '/student/home' : '/login',  // Cambia la ruta según sesión
      routes: appRoutes,
    );
  }
}
