import 'package:flutter/material.dart';
import 'theme.dart';
import 'routes.dart';

void main() {
  runApp(EduNetApp());
}

class EduNetApp extends StatelessWidget {
  const EduNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduNet',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialRoute: '/login',
      routes: appRoutes,
    );
  }
}