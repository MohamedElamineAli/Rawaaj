import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String label;
  final String? hint;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final String? disabledHint;

  const DropdownWidget({
    Key? key,
    required this.label,
    this.hint,
    required this.items,
    this.onChanged,
    this.disabledHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: items.contains(hint) ? hint : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF1F4FE),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          disabledHint: Text(disabledHint ?? ''),
          dropdownColor: Colors.white,
        ),
      ],
    );
  }
}
