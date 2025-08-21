import 'package:flutter/material.dart';
import '../controllers/projects_controller.dart';
import '../widgets/project_card.dart';
import '../widgets/tag_chip.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ProjectsController _controller = ProjectsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildFilters(context),
            const SizedBox(height: 32),
            _buildProjectsGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Projects',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'A collection of projects I\'ve worked on, showcasing various technologies and approaches.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Filter by Technology:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 16),
                if (_controller.selectedTechTags.isNotEmpty)
                  TextButton.icon(
                    onPressed: _controller.clearFilters,
                    icon: const Icon(Icons.clear, size: 16),
                    label: const Text('Clear'),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _controller.allTechTags.map((tag) {
                final isSelected = _controller.selectedTechTags.contains(tag);
                return TagChip(
                  label: tag,
                  isSelected: isSelected,
                  onTap: () => _controller.toggleTechTag(tag),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        final projects = _controller.filteredProjects;

        if (projects.isEmpty) {
          return _buildEmptyState(context);
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;
            if (constraints.maxWidth > 1200) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 800) {
              crossAxisCount = 2;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 0.8,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ProjectCard(project: projects[index]);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'No projects found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters to see more projects.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _controller.clearFilters,
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}
