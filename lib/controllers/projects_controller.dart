import 'package:flutter/foundation.dart';
import '../models/project.dart';
import '../data/projects.dart' as data;

class ProjectsController extends ChangeNotifier {
  final List<Project> _allProjects = List.of(data.allProjects);
  final Set<String> _selectedTechTags = {};

  List<Project> get allProjects => _allProjects;
  List<String> get selectedTechTags => _selectedTechTags.toList()..sort();

  List<String> get allTechTags {
    final s = <String>{};
    for (final p in _allProjects) {
      s.addAll(p.techTags);
    }
    final l = s.toList()..sort();
    return l;
  }

  void toggleTechTag(String tag) {
    if (_selectedTechTags.contains(tag)) {
      _selectedTechTags.remove(tag);
    } else {
      _selectedTechTags.add(tag);
    }
    notifyListeners();
  }

  void clearFilters() {
    _selectedTechTags.clear();
    notifyListeners();
  }

  List<Project> get filteredProjects {
    if (_selectedTechTags.isEmpty) return _allProjects;
    return _allProjects
        .where((p) => p.techTags.any(_selectedTechTags.contains))
        .toList();
  }
}
