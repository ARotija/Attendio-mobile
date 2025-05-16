import 'package:flutter/material.dart';

class TeacherScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final String? title;

  const TeacherScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    this.title,
  });

  static const List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Acasă'),
    BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Note'),
    BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Prezențe'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Căutare'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  ];

  static const List<String> _routes = [
    '/teacher/home',
    '/teacher/notes',
    '/teacher/attendance',
    '/teacher/search',
    '/teacher/profile',
  ];

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;
    Navigator.pushReplacementNamed(context, _routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null ? AppBar(title: Text(title!)) : null,
      body: SafeArea(child: body),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  BottomNavigationBar _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) => _onItemTapped(context, i),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor: Colors.grey,
      items: _navItems,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}