import 'package:flutter/material.dart';

/// A reusable sidebar drawer for navigation, adapting items based on user role.
class SidebarDrawer extends StatelessWidget {
  final String role;          // 'teacher', 'student', or 'tutor'
  final String currentRoute;  // route name to highlight the active item

  const SidebarDrawer({
    super.key,
    required this.role,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final items = _getNavItems();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              _headerTitle(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Navigation options
          ...items.map((item) {
            final isSelected = currentRoute == item.route;
            return ListTile(
              leading: Icon(item.icon, color: isSelected ? Theme.of(context).colorScheme.secondary : null),
              title: Text(
                item.label,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onTap: () {
                if (!isSelected) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(item.route);
                } else {
                  Navigator.of(context).pop();
                }
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  /// Returns a human-readable header based on the role.
  String _headerTitle() {
    final capitalized = role[0].toUpperCase() + role.substring(1);
    return '$capitalized Panel';
  }

  /// Builds the list of navigation items depending on the user role.
  List<_NavItem> _getNavItems() {
    switch (role) {
      case 'teacher':
        return [
          _NavItem('Home', Icons.home, '/teacher/home'),
          _NavItem('Notas', Icons.note, '/teacher/notes'),
          _NavItem('Asistencias', Icons.how_to_reg, '/teacher/attendance'),
          _NavItem('Cauta', Icons.search, '/teacher/search'),
          _NavItem('Perfil', Icons.settings, '/teacher/profile'),
        ];
      case 'student':
        return [
          _NavItem('Home', Icons.home, '/student/home'),
          _NavItem('Note', Icons.note, '/student/notes'),
          _NavItem('Absente', Icons.how_to_reg, '/student/attendance'),
          _NavItem('Notificatii', Icons.notifications, '/student/notifications'),
          _NavItem('Perfil', Icons.settings, '/student/profile'),
        ];
      case 'tutor':
        return [
          _NavItem('Home', Icons.home, '/tutor/home'),
          _NavItem('Note', Icons.note, '/tutor/notes'),
          _NavItem('Absente', Icons.how_to_reg, '/tutor/attendance'),
          _NavItem('Notificari', Icons.notifications, '/tutor/notifications'),
          _NavItem('Perfil', Icons.settings, '/tutor/profile'),
        ];
      default:
        return [];
    }
  }
}

/// Simple data class for a drawer navigation item.
class _NavItem {
  final String label;
  final IconData icon;
  final String route;

  _NavItem(this.label, this.icon, this.route);
}
