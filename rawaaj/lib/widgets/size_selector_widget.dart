import 'package:flutter/material.dart';

class SizeSelectorWidget extends StatefulWidget {
  const SizeSelectorWidget({Key? key}) : super(key: key);

  @override
  _SizeSelectorWidgetState createState() => _SizeSelectorWidgetState();
}

class _SizeSelectorWidgetState extends State<SizeSelectorWidget> {
  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  final Set<String> selectedSizes = {};
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: sizes.map((size) {
        bool isSelected = selectedSizes.contains(size);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedSizes.remove(size);
              } else {
                selectedSizes.add(size);
              }
            });
          },
          child: Container(
            height: 30,
            width: 52,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.transparent,
                width: 1.5,
              ),
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                size,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
