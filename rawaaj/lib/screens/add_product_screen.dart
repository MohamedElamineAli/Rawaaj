import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/widgets/dropdown_widget.dart';
import 'package:rawaaj/widgets/dynamic_material_input.dart';
import '../cubit/add_product_cubit.dart';
import '../widgets/image_picker_widget.dart';
import '../widgets/sub_screen_app_bar.dart';
import '../widgets/size_selector_widget.dart';
import '../widgets/color_selector_widget.dart';
import '../widgets/save_button.dart';
import '../widgets/text_field_widget.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = [
      "Jackets",
      "Jeans",
      "Shirts",
      "Shoes",
      "Sportswear",
      "Suits",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SubScreenAppBar(name: "Add Product"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AddProductCubit, AddProductState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ImagePickerWidget(),
                    if (state.product.images.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Please upload at least one image.",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),

            BlocBuilder<AddProductCubit, AddProductState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: 'Price',
                      hint: 'Enter price',
                      onChanged: (value) {
                        final price = double.tryParse(value) ?? 0.0;
                        context.read<AddProductCubit>().updatePrice(price);
                      },
                    ),
                    if (state.product.price <= 0)
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Price must be greater than 0.",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 10),

            BlocBuilder<AddProductCubit, AddProductState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: 'Description',
                      hint: 'Enter description',
                      onChanged: (value) {
                        context.read<AddProductCubit>().updateDescription(value);
                      },
                    ),
                    if (state.product.description.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Description cannot be empty.",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 10),

            BlocBuilder<AddProductCubit, AddProductState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownWidget(
                      label: "Categories",
                      items: categories,
                      hint: "Shirts",
                      onChanged: (value) {
                        context.read<AddProductCubit>().updateCategoryId(categories.indexOf(value ?? "Shirts") + 1);
                      },
                    ),
                    if (state.product.categoryId == 0)
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Please select a category.",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),
            const Text(
              'Sizes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const SizeSelectorWidget(),

            const SizedBox(height: 20),
            const Text(
              'Colors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const ColorSelectorWidget(),

            const SizedBox(height: 20),
            const Text(
              'Materials',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const DynamicMaterialsInput(),

            BlocBuilder<AddProductCubit, AddProductState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.product.materials.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Please add at least one material.",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 10),

            BlocBuilder<AddProductCubit, AddProductState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: 'Origin',
                      hint: 'Enter origin',
                      onChanged: (value) {
                        context.read<AddProductCubit>().updateOrigin(value);
                      },
                    ),
                    if (state.product.origin.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Origin cannot be empty.",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 30),

            BlocBuilder<AddProductCubit, AddProductState>(
              builder: (context, state) {
                return SaveButton(
                  isLoading: state.isLoading,
                  onPressed: () async {
                    final cubit = context.read<AddProductCubit>();

                    if (cubit.canAddProduct()) {

                      final isProductAdded = await cubit.addProduct();

                      if (isProductAdded) {
                        Navigator.pop(context);
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
