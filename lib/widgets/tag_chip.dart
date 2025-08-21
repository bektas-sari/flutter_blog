import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isSmall;
  final VoidCallback onTap;

  const TagChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 8 : 12,
          vertical: isSmall ? 4 : 6,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isSmall ? 11 : 12,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? Colors.white
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
