import 'package:flutter/material.dart';
import '../../widgets/scaffolds/teacher_scaffold.dart';

class TeacherProfileScreen extends StatelessWidget {
  static const routeName = '/teacher/profile';

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 4,
      title: 'Profilul meu',
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Imagen minimalista de profesor (vectorial/silueta)
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', // Imagen minimalista de profesor
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Prof. Maria Popescu',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Profesor de Matematică',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 24),
            _buildProfileSection(
              context,
              title: 'Informații personale',
              children: [
                _buildInfoItem(context, 
                  icon: Icons.phone, 
                  text: '+40 721 123 456',
                  iconColor: Theme.of(context).primaryColor,
                ),
                _buildInfoItem(context, 
                  icon: Icons.email, 
                  text: 'maria.popescu@example.com',
                  iconColor: Theme.of(context).primaryColor,
                ),
                _buildInfoItem(context, 
                  icon: Icons.school, 
                  text: 'Colegiul Național "Unirea"',
                  iconColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
            _buildProfileSection(
              context,
              title: 'Setări cont',
              children: [
                _buildSettingsItem(
                  context,
                  icon: Icons.lock,
                  text: 'Schimbă parola',
                  iconColor: Colors.amber,
                  onTap: () {},
                ),
                _buildSettingsItem(
                  context,
                  icon: Icons.logout,
                  text: 'Deconectare',
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(children: children),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, {
    required IconData icon, 
    required String text,
    Color iconColor = Colors.grey,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
      minLeadingWidth: 24,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    Color textColor = Colors.black,
    Color iconColor = Colors.grey,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      minLeadingWidth: 24,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}