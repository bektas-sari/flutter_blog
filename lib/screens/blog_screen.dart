import 'package:flutter/material.dart';
import '../controllers/blog_controller.dart';
import '../widgets/post_card.dart';
import '../widgets/tag_chip.dart';
import '../widgets/search_bar.dart' as custom;
import '../widgets/pagination.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final BlogController _controller = BlogController();
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 400) {
      if (!_showBackToTop) {
        setState(() {
          _showBackToTop = true;
        });
      }
    } else {
      if (_showBackToTop) {
        setState(() {
          _showBackToTop = false;
        });
      }
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildSearchAndFilters(context),
            const SizedBox(height: 32),
            _buildPostsList(context),
            const SizedBox(height: 32),
            _buildPagination(context),
          ],
        ),
      ),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              child: const Icon(Icons.keyboard_arrow_up),
            )
          : null,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Blog',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Thoughts, tutorials, and insights on software development.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            custom.SearchBar(
              hintText: 'Search posts...',
              onChanged: _controller.updateSearchQuery,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Filter by tags:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 16),
                if (_controller.selectedTags.isNotEmpty ||
                    _controller.searchQuery.isNotEmpty)
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
              children: _controller.allTags.map((tag) {
                final isSelected = _controller.selectedTags.contains(tag);
                return TagChip(
                  label: tag,
                  isSelected: isSelected,
                  onTap: () => _controller.toggleTag(tag),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPostsList(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        final posts = _controller.paginatedPosts;

        if (posts.isEmpty) {
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
                childAspectRatio: 0.75,
              ),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(post: posts[index]);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPagination(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        if (_controller.totalPages <= 1) {
          return const SizedBox.shrink();
        }

        return Pagination(
          currentPage: _controller.currentPage,
          totalPages: _controller.totalPages,
          onPageChanged: _controller.goToPage,
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
            'No posts found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters to find what you\'re looking for.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
            textAlign: TextAlign.center,
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
