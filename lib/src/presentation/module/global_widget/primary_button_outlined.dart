import 'package:flutter/material.dart';

class PrimaryButtonOutlined extends StatelessWidget {
  const PrimaryButtonOutlined({
    super.key,
    required this.onPressed,
    this.title
  });

  final VoidCallback onPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // backgroundColor: Theme.of(context).colorScheme.primary,
          side: BorderSide(width: 2.0, color: Theme.of(context).colorScheme.primary),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        title ?? 'OK',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary
        ),
      ),
    );
  }
}
