import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/about_screen.dart';
import '../screens/projects_screen.dart';
import '../screens/blog_screen.dart';
import '../screens/post_detail_screen.dart';
import '../screens/contact_screen.dart';
import '../widgets/main_layout.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/about',
            name: 'about',
            builder: (context, state) => const AboutScreen(),
          ),
          GoRoute(
            path: '/projects',
            name: 'projects',
            builder: (context, state) => const ProjectsScreen(),
          ),
          GoRoute(
            path: '/blog',
            name: 'blog',
            builder: (context, state) => const BlogScreen(),
          ),
          GoRoute(
            path: '/contact',
            name: 'contact',
            builder: (context, state) => const ContactScreen(),
          ),
          GoRoute(
            path: '/post/:slug',
            name: 'post-detail',
            builder: (context, state) {
              final slug = state.pathParameters['slug']!;
              return PostDetailScreen(slug: slug);
            },
          ),
        ],
      ),
    ],
  );
}
