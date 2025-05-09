import 'package:flutter/material.dart';
import 'theme.dart';
import 'routes.dart';

void main() {
  runApp(Attendio());
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