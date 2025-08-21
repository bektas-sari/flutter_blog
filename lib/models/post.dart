class Post {
  final String title;
  final String slug;
  final String excerpt;
  final String content;
  final DateTime date;
  final List<String> tags;
  final String? heroImage;

  const Post({
    required this.title,
    required this.slug,
    required this.excerpt,
    required this.content,
    required this.date,
    this.tags = const [],
    this.heroImage,
  });
}
