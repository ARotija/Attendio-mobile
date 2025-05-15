import 'package:flutter/material.dart';
import '../../widgets/scaffolds/teacher_scaffold.dart';

class TeacherSearchScreen extends StatelessWidget {
  static const routeName = '/teacher/search';

  @override
  Widget build(BuildContext context) {
    return TeacherScaffold(
      currentIndex: 3,
      title: 'Căutare',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Caută elev, clasă sau materie...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildSearchOption(
                    context,
                    icon: Icons.people,
                    label: 'Elevi',
                    color: Colors.blue,
                  ),
                  _buildSearchOption(
                    context,
                    icon: Icons.school,
                    label: 'Clase',
                    color: Colors.green,
                  ),
                  _buildSearchOption(
                    context,
                    icon: Icons.book,
                    label: 'Materii',
                    color: Colors.orange,
                  ),
                  _buildSearchOption(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Orar',
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          // Acción al seleccionar esta opción de búsqueda
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}