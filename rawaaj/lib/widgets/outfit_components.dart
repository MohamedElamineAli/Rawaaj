import 'package:flutter/material.dart';

class OutfitComponents extends StatefulWidget {
  const OutfitComponents({Key? key}) : super(key: key);

  @override
  State<OutfitComponents> createState() => _OutfitComponentsState();
}

class _OutfitComponentsState extends State<OutfitComponents> {
  // List to hold the items; 'true' means it's an add button, 'false' means it's a regular item
  final List<bool> _items = [true]; // Start with only the Add button

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final isAddButton = _items[index];
          return _buildComponentItem(index, isAddButton);
        },
      ),
    );
  }

  Widget _buildComponentItem(int index, bool isAddButton) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isAddButton
            ? GestureDetector(
          onTap: _addItem,
          child: const Center(
            child: Icon(
              Icons.add_circle_outline,
              size: 100,
              color: Color(0xFFD9D9D9),
            ),
          ),
        )
            : Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/grey.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () => _removeItem(index),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addItem() {
    setState(() {
      _items.insert(_items.length - 1, false);
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }
}
