import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // <-- Importa dotenv
import 'theme.dart';
import 'routes.dart';

Future<void> main() async {
  // Cargar variables de entorno desde el archivo .env
  await dotenv.load(fileName: ".env");

  runApp(const Attendio());
}

class Attendio extends StatelessWidget {
  const Attendio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendio',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialRoute: '/login',
      routes: appRoutes,
    );
  }
}
