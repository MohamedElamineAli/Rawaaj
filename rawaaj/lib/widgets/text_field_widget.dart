import 'package:flutter/material.dart';

const defaultHintColor = Color(0xFF9EB4E8);

class CustomTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final String hint;
  final Color hintColor;

  const CustomTextField({
    Key? key,
    required this.label,
    this.maxLines = 1,
    this.hint = "Required",
    this.hintColor = defaultHintColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: TextField(
            maxLines: maxLines,
            decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                filled: true,
                fillColor: Color(0xFFF1F4FE),
                hintStyle: TextStyle(color: hintColor, fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    );
  }
}
