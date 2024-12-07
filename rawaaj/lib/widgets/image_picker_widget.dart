import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.25),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: IconButton(
        icon: const Icon(Icons.add_photo_alternate_rounded, size: 80, color: Colors.white),
        onPressed: () {
          // Handle image picker
        },
      ),
    );
  }
}
