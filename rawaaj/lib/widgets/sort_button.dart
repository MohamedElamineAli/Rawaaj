import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const SortButton({Key? key, required this.label, this.isSelected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {},
      selectedColor: Colors.blue.shade100,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isSelected ? Colors.blue : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
