import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../cubit/add_product_cubit.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final cubit = context.read<AddProductCubit>();
      final updatedImages = List<File>.from(cubit.state.product.images)
        ..add(File(pickedFile.path));
      cubit.updateImages(updatedImages);
    }
  }

  void _removeImage(BuildContext context, int index) {
    final cubit = context.read<AddProductCubit>();
    final updatedImages = List<File>.from(cubit.state.product.images)
      ..removeAt(index);
    cubit.updateImages(updatedImages);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        final images = state.product.images;
        final pageController = PageController();

        return images.isEmpty
            ? GestureDetector(
          onTap: () => _pickImage(context),
          child: Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.25),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Center(
              child: Icon(
                Icons.add_photo_alternate_rounded,
                size: 100,
                color: Colors.white,
              ),
            ),
          ),
        )
            : Stack(
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: pageController,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          images[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () => _removeImage(context, index),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.remove_circle_outline_rounded,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: images.length,
                  effect: const WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: GestureDetector(
                onTap: () => _pickImage(context),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFDADADA)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.add_photo_alternate_rounded,
                    color: Color(0xFFB5B5B5),
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
