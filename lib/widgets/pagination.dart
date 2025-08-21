import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed:
              currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          icon: const Icon(Icons.chevron_left),
        ),
        const SizedBox(width: 8),
        ..._buildPageNumbers(context),
        const SizedBox(width: 8),
        IconButton(
          onPressed: currentPage < totalPages
              ? () => onPageChanged(currentPage + 1)
              : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  List<Widget> _buildPageNumbers(BuildContext context) {
    List<Widget> pages = [];

    // Show first page
    if (totalPages > 0) {
      pages.add(_buildPageButton(context, 1));
    }

    // Show ellipsis if needed
    if (currentPage > 3) {
      pages.add(const Text('...'));
    }

    // Show pages around current page
    int start = (currentPage - 1).clamp(2, totalPages - 1);
    int end = (currentPage + 1).clamp(2, totalPages - 1);

    for (int i = start; i <= end; i++) {
      if (i != 1 && i != totalPages) {
        pages.add(_buildPageButton(context, i));
      }
    }

    // Show ellipsis if needed
    if (currentPage < totalPages - 2) {
      pages.add(const Text('...'));
    }

    // Show last page
    if (totalPages > 1) {
      pages.add(_buildPageButton(context, totalPages));
    }

    return pages;
  }

  Widget _buildPageButton(BuildContext context, int page) {
    final isSelected = page == currentPage;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () => onPageChanged(page),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            page.toString(),
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
