import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../cubit/add_outfit_cubit.dart';

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({Key? key}) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final cubit = context.read<AddOutfitCubit>();
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        cubit.updateOutfitImage(File(pickedFile.path));
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _removeImage(BuildContext context) {
    final cubit = context.read<AddOutfitCubit>();
    cubit.updateOutfitImage(File('')); // Reset the image path to an empty string
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOutfitCubit, AddOutfitState>(
      builder: (context, state) {
        final outfitImage = state.outfit.outfitImage;

        return Stack(
          children: [
            GestureDetector(
              onTap: () => _pickImage(context),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Container(
                    height: 400,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(12),
                      image: outfitImage.path.isNotEmpty
                          ? DecorationImage(
                        image: FileImage(outfitImage),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: outfitImage.path.isEmpty
                        ? const Center(
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        size: 90,
                        color: Colors.white,
                      ),
                    )
                        : null,
                  ),
                ),
              ),
            ),
            if (outfitImage.path.isNotEmpty)
              Positioned(
                top: -5,
                right: 60,
                child: GestureDetector(
                  onTap: () => _removeImage(context),
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
    );
  }
}
