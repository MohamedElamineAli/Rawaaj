import 'package:flutter/material.dart';

const defaultHintColor = Color(0xFF9EB4E8);

class CustomTextField extends StatelessWidget {
  final String? label;
  final int maxLines;
  final String hint;
  final Color hintColor;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    this.label,
    this.maxLines = 1,
    this.hint = "Required",
    this.hintColor = defaultHintColor,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: label != null,
          child: Text(
            label ?? '',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: TextField(
            maxLines: maxLines,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              filled: true,
              fillColor: const Color(0xFFF1F4FE),
              hintStyle: TextStyle(
                color: hintColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
