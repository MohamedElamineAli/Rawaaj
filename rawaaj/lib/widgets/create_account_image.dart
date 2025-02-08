import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../cubit/create_account_cubit.dart';

class CreateAccountImage extends StatelessWidget {
  final bool isShopAccount;

  const CreateAccountImage({super.key, required this.isShopAccount});

  Future<void> _pickImage(BuildContext context) async {
    final cubit = context.read<CreateAccountCubit>();
    final picker = ImagePicker();

    // Pick an image from the gallery
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      cubit.updateImage(pickedFile.path);
    }
  }

  void _removeImage(BuildContext context) {
    final cubit = context.read<CreateAccountCubit>();
    // Reset the image to its default (empty or placeholder)
    cubit.updateImage('');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountCubit, CreateAccountState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isShopAccount ?
              'Create\nAccount' :
              'Create Shop\nAccount',
              style: const TextStyle(
                fontSize: 55,
                fontWeight: FontWeight.w900,
                height: 1.0,
                letterSpacing: 0.8,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              children: [
                GestureDetector(
                  onTap: () => _pickImage(context),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF004BFE),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      image: state.image.isNotEmpty
                          ? DecorationImage(
                        image: FileImage(File(state.image)),
                        fit: BoxFit.cover,
                      )
                          : null, // No image if the state.image is empty
                    ),
                    child: state.image.isEmpty
                        ? const Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Color(0xFF004BFE),
                        size: 38,
                      ),
                    )
                        : null, // Show camera icon only if no image is selected
                  ),
                ),
                if (state.image.isNotEmpty)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: GestureDetector(
                      onTap: () => _removeImage(context),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
