import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String? trailingText;
  final VoidCallback onTap;

  const SettingsItem({
    required this.title,
    this.trailingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            if (trailingText != null)
              Text(
                trailingText!,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
