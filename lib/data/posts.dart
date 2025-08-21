import '../models/post.dart';

final List<Post> allPosts = [
  Post(
    title: 'Hello Flutter Blog',
    slug: 'hello-flutter-blog',
    excerpt: 'İlk gönderi – veri yapısı ve ekran testi.',
    content: '''
Bu bir **örnek içerik**. Düz metin olarak tutulur.

- Madde 1
- Madde 2
''',
    date: DateTime(2025, 8, 1),
    tags: ['flutter', 'demo'],
  ),
  Post(
    title: 'State Management Notları',
    slug: 'state-management-notlari',
    excerpt: 'ChangeNotifier ile basit durum yönetimi.',
    content: '''
Bu içerikte ChangeNotifier tabanlı basit bir controller tasarımını görüyoruz.
''',
    date: DateTime(2025, 8, 10),
    tags: ['flutter', 'state', 'notifier'],
  ),
];
