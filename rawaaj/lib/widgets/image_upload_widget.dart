import 'package:flutter/material.dart';

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(
              Icons.add_photo_alternate_rounded,
              size: 90,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
