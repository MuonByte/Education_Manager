import 'package:flutter/material.dart';

class UserSection extends StatelessWidget {
  final String text;
  const UserSection({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.person_2_rounded, size: 30),
          const SizedBox(width: 12),
          Expanded(child: Text(
            text,
            style: TextStyle(
              color: Colors.black
            ),
          ),
          ),
          const Icon(Icons.edit, size: 20, color: Colors.grey),
        ],
      ),
    );
  }
}
