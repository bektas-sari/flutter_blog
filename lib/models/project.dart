class Project {
  final String title;
  final String description;
  final List<String> techTags;
  final String repoUrl;
  final String? siteUrl;
  final String? imageUrl;

  const Project({
    required this.title,
    required this.description,
    this.techTags = const [],
    required this.repoUrl,
    this.siteUrl,
    this.imageUrl,
  });
}
