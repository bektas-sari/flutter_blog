import 'package:flutter/foundation.dart';
import '../models/post.dart';
import '../data/posts.dart' as data;

class BlogController extends ChangeNotifier {
  // Veri
  final List<Post> _allPosts = List.of(data.allPosts);

  // Durum
  String _searchQuery = '';
  final Set<String> _selectedTags = {};
  int _currentPage = 0;
  final int _pageSize = 10;

  // --- GETTER’LAR (ekranların bekledikleri) ---
  List<Post> get allPosts => _allPosts;
  String get searchQuery => _searchQuery;
  List<String> get selectedTags => _selectedTags.toList()..sort();

  List<String> get allTags {
    final s = <String>{};
    for (final p in _allPosts) {
      s.addAll(p.tags);
    }
    final l = s.toList()..sort();
    return l;
  }

  int get currentPage => _currentPage;
  int get totalPages {
    final total = filteredPosts.length;
    if (total == 0) return 1;
    return (total / _pageSize).ceil();
  }

  // --- Komutlar (ekranların çağırdıkları) ---
  void updateSearchQuery(String q) {
    _searchQuery = q.trim();
    _currentPage = 0;
    notifyListeners();
  }

  void toggleTag(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    _currentPage = 0;
    notifyListeners();
  }

  void clearFilters() {
    _selectedTags.clear();
    _searchQuery = '';
    _currentPage = 0;
    notifyListeners();
  }

  void goToPage(int page) {
    final clamped = page.clamp(0, totalPages - 1);
    if (clamped != _currentPage) {
      _currentPage = clamped;
      notifyListeners();
    }
  }

  // --- Türetilmiş listeler ---
  List<Post> get filteredPosts {
    final q = _searchQuery.toLowerCase();
    final list = _allPosts.where((post) {
      final matchesQuery = q.isEmpty ||
          post.title.toLowerCase().contains(q) ||
          post.excerpt.toLowerCase().contains(q) ||
          post.content.toLowerCase().contains(q);

      final matchesTags = _selectedTags.isEmpty ||
          _selectedTags.any((t) => post.tags.contains(t));

      return matchesQuery && matchesTags;
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return list;
  }

  List<Post> get paginatedPosts {
    final start = _currentPage * _pageSize;
    final end = (start + _pageSize).clamp(0, filteredPosts.length);
    if (start >= end) return const [];
    return filteredPosts.sublist(start, end);
  }

  // --- Yardımcı ---
  Post? getPostBySlug(String slug) {
    try {
      return _allPosts.firstWhere((p) => p.slug == slug);
    } catch (_) {
      return null;
    }
  }
}
