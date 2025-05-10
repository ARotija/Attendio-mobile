import 'package:flutter/material.dart';
import '../../widgets/sidebar_drawer.dart';

class TeacherSearchScreen extends StatefulWidget {
  static const routeName = '/teacher/search';

  @override
  _TeacherSearchScreenState createState() => _TeacherSearchScreenState();
}

class _TeacherSearchScreenState extends State<TeacherSearchScreen> {
  final _searchController = TextEditingController();
  String selectedClass = '9A';
  final List<String> classes = ['9A', '10B', '11C'];

  List<Map<String, String>> searchResults = [];

  void _performSearch() {
    setState(() {
      searchResults = [
        { 'student': 'Bocai Robert', 'subject': 'Istorie', 'status': 'Absent' },
        { 'student': 'Ana Mari', 'subject': 'Biologie', 'status': 'Prezent' },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarDrawer(role: 'teacher', currentRoute: TeacherSearchScreen.routeName),
      appBar: AppBar(title: Text('Cautare')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          DropdownButtonFormField<String>(
            value: selectedClass,
            items: classes
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (v) => setState(() => selectedClass = v!),
            decoration: InputDecoration(labelText: 'Selecteaza clasa'),
          ),
          SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(labelText: 'Cautare elevi'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _performSearch,
            ),
          ]),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (_, i) {
                final result = searchResults[i];
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(result['student']!),
                  subtitle: Text('${result['subject']} · ${result['status']}'),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
