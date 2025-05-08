import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class NotificationBell extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const NotificationBell({
    Key? key,
    required this.count,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return IconButton(
      icon: badges.Badge(
        position: badges.BadgePosition.topEnd(top: -4, end: -4),
        showBadge: count > 0,
        badgeContent: Text(
          count.toString(),
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
        child: Icon(Icons.notifications),
      ),
      onPressed: onTap,
    );
  }
}
