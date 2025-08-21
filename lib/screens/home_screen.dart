import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildFeaturesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.surface,
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: isDesktop ? 80 : 60,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.person,
                  size: isDesktop ? 80 : 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome to My Blog',
                style: isDesktop
                    ? Theme.of(context).textTheme.displayLarge
                    : Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  'Sharing insights on Flutter development, web technologies, and software engineering best practices.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.8),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => context.go('/blog'),
                icon: const Icon(Icons.article),
                label: const Text('Read the Blog'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'What You\'ll Find Here',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 800;

              if (isDesktop) {
                return Row(
                  children: [
                    Expanded(
                        child: _buildFeatureCard(
                      context,
                      Icons.code,
                      'Development',
                      'In-depth tutorials and best practices for modern web and mobile development.',
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: _buildFeatureCard(
                      context,
                      Icons.lightbulb_outline,
                      'Insights',
                      'Thoughts on technology trends, productivity tips, and industry insights.',
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: _buildFeatureCard(
                      context,
                      Icons.work_outline,
                      'Projects',
                      'Showcase of personal and professional projects with detailed breakdowns.',
                    )),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildFeatureCard(
                      context,
                      Icons.code,
                      'Development',
                      'In-depth tutorials and best practices for modern web and mobile development.',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureCard(
                      context,
                      Icons.lightbulb_outline,
                      'Insights',
                      'Thoughts on technology trends, productivity tips, and industry insights.',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureCard(
                      context,
                      Icons.work_outline,
                      'Projects',
                      'Showcase of personal and professional projects with detailed breakdowns.',
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, IconData icon, String title, String description) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              icon,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.8),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
