import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(project.title),
        subtitle: Text(project.description),
        onTap: () {
          // Örn: repo linki açılabilir
        },
      ),
    );
  }
}
