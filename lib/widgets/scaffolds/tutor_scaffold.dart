import 'package:flutter/material.dart';

class TutorScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final AppBar? appBar;
  final int notificationCount;
  final VoidCallback? onNotificationTap;

  const TutorScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    this.appBar,
    this.notificationCount = 0,
    this.onNotificationTap,
  });

  static const List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Acasă'),
    BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Note'),
    BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Prezențe'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  ];

  static const List<String> _routes = [
    '/tutor/home',
    '/tutor/notes',
    '/tutor/attendance',
    '/tutor/profile',
  ];

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;
    Navigator.pushReplacementNamed(context, _routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? _buildDefaultAppBar(context),
      body: SafeArea(child: body),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  AppBar _buildDefaultAppBar(BuildContext context) {
    return AppBar(
      title: Text(_getTitle(currentIndex)),
      actions: [
        if (onNotificationTap != null)
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications),
                if (notificationCount > 0)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        notificationCount.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: onNotificationTap,
          ),
      ],
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0: return 'Copiii mei';
      case 1: return 'Note copii';
      case 2: return 'Prezențe copii';
      case 3: return 'Profil tutor';
      default: return 'Tutor';
    }
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