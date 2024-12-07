import 'package:flutter/material.dart';
import '../widgets/image_picker_widget.dart';
import '../widgets/sub_screen_app_bar.dart';
import '../widgets/text_field_widget.dart';
import '../widgets/size_selector_widget.dart';
import '../widgets/color_selector_widget.dart';
import '../widgets/save_button.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar(name: "Add Product",),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImagePickerWidget(),
            const SizedBox(height: 20),
            const CustomTextField(label: 'Price'),
            const SizedBox(height: 10),
            const CustomTextField(label: 'Description'),
            const SizedBox(height: 20),
            const Text('Sizes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            const SizedBox(height: 10),
            const SizeSelectorWidget(),
            const SizedBox(height: 20),
            const Text('Colors', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            const ColorSelectorWidget(),
            const SizedBox(height: 20),
            const CustomTextField(label: 'Materials'),
            const SizedBox(height: 10),
            const CustomTextField(label: 'Origin'),
            const SizedBox(height: 30),
            const SaveButton(),
          ],
        ),
      ),
    );
  }
}
