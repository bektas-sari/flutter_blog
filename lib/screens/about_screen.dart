import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 800;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, isDesktop),
                const SizedBox(height: 32),
                _buildBioSection(context, isDesktop),
                const SizedBox(height: 32),
                _buildSkillsSection(context),
                const SizedBox(height: 32),
                _buildExperienceSection(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDesktop) {
    return Row(
      children: [
        if (isDesktop) ...[
          CircleAvatar(
            radius: 60,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 32),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isDesktop) ...[
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
              Text(
                'About Me',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Full-Stack Developer & Tech Enthusiast',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBioSection(BuildContext context, bool isDesktop) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello! 👋',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'I\'m a passionate full-stack developer with over 5 years of experience building web and mobile applications. I love creating efficient, scalable solutions and sharing knowledge with the developer community.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'When I\'m not coding, you can find me exploring new technologies, contributing to open-source projects, or writing about my experiences in software development. I believe in continuous learning and enjoy tackling complex problems with creative solutions.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'This blog is where I share my journey, insights, and tutorials on various aspects of software development, from frontend frameworks to backend architecture and everything in between.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    final skills = [
      'Flutter',
      'React',
      'Node.js',
      'Python',
      'TypeScript',
      'Firebase',
      'PostgreSQL',
      'MongoDB',
      'AWS',
      'Docker',
      'Git',
      'REST APIs',
      'GraphQL',
      'CI/CD',
      'Agile'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills & Technologies',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) {
            return Chip(
              label: Text(skill),
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience Highlights',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        _buildExperienceCard(
          context,
          'Senior Full-Stack Developer',
          'Tech Solutions Inc.',
          '2022 - Present',
          'Leading development of scalable web applications using React, Node.js, and cloud technologies. Mentoring junior developers and implementing best practices.',
        ),
        const SizedBox(height: 16),
        _buildExperienceCard(
          context,
          'Mobile App Developer',
          'StartupXYZ',
          '2020 - 2022',
          'Built cross-platform mobile applications using Flutter and React Native. Collaborated with design teams to create intuitive user experiences.',
        ),
        const SizedBox(height: 16),
        _buildExperienceCard(
          context,
          'Frontend Developer',
          'Digital Agency',
          '2019 - 2020',
          'Developed responsive web applications and e-commerce platforms. Worked with various CMS and frontend frameworks.',
        ),
      ],
    );
  }

  Widget _buildExperienceCard(BuildContext context, String title,
      String company, String period, String description) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        company,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ],
                  ),
                ),
                Text(
                  period,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
