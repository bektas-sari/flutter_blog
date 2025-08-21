import 'package:flutter/material.dart';
import '../models/post.dart';
import '../data/posts.dart' as data;

class PostDetailScreen extends StatefulWidget {
  final Post? post;
  final String? slug;

  const PostDetailScreen({super.key, this.post, this.slug});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  Post? _post;

  @override
  void initState() {
    super.initState();
    _post = widget.post ?? _findBySlug(widget.slug);
  }

  Post? _findBySlug(String? slug) {
    if (slug == null || slug.isEmpty) return null;
    try {
      return data.allPosts.firstWhere((p) => p.slug == slug);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_post == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Post not found')),
        body: const Center(child: Text('Gönderi bulunamadı')),
      );
    }

    final post = _post!;
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.heroImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(post.heroImage!),
              ),
            const SizedBox(height: 12),
            Text(
              post.excerpt,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            // SOL ŞERİT: borderLeft yerine Border(left: ...)
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                border: Border(
                  left: BorderSide(color: Colors.blue, width: 4),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                post.content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: post.tags
                  .map((t) => Chip(label: Text('#$t')))
                  .toList(growable: false),
            ),
            const SizedBox(height: 8),
            Text(
              'Yayın: ${post.date.toIso8601String().split("T").first}',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
