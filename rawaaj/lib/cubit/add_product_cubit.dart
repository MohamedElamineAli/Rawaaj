import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:rawaaj/constants/default_cubit_product.dart';
import 'package:rawaaj/services/product_service.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';
import 'package:equatable/equatable.dart';
part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {

  AddProductCubit(Product product) : super(AddProductState(product: product));

  void updateImages(List<File> images) {
    emit(state.copyWith(images: images));
  }

  void updateCategoryId(int categoryId) {
    emit(state.copyWith(categoryId: categoryId));
  }

  void updatePrice(double price) {
    emit(state.copyWith(price: price));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateVariation(List<String> variation) {
    emit(state.copyWith(variation: variation));
  }

  void updateMaterials(List<String> materials) {
    emit(state.copyWith(materials: materials));
  }

  void updateOrigin(String origin) {
    emit(state.copyWith(origin: origin));
  }

  void updateSizes(List<int> sizes) {
    emit(state.copyWith(sizes: sizes));
  }

  void updateColors(List<int> colors) {
    emit(state.copyWith(colors: colors));
  }

  void updateShopId(int? shopId) {
    emit(state.copyWith(shopId: shopId));
  }

  void updateMaterialAtIndex(int index, String value) {
    final updatedMaterials = List<String>.from(state.product.materials);
    updatedMaterials[index] = value;
    updateMaterials(updatedMaterials);
  }

  void removeMaterialAtIndex(int index) {
    final updatedMaterials = List<String>.from(state.product.materials)
      ..removeAt(index);
    updateMaterials(updatedMaterials);
  }

  void addMaterial(String material) {
    final updatedMaterials = List<String>.from(state.product.materials)
      ..add(material);
    updateMaterials(updatedMaterials);
  }

  /// Checks if all required fields are filled
  bool canAddProduct() {
    final product = state.product;
    return product.images.isNotEmpty &&
        product.categoryId != 0 &&
        product.price > 0 &&
        product.description.isNotEmpty &&
        product.materials.isNotEmpty &&
        product.origin.isNotEmpty &&
        product.sizes.isNotEmpty &&
        product.colors.isNotEmpty;
  }

  /// Add button logic (can include saving to backend or triggering next steps)
  Future<bool> addProduct() async {
    if (canAddProduct()) {
      emit(AddProductState(product: state.product, isLoading: true));

      final productService = ProductService();

      final productId = await productService.addProduct(state.product);

      if(productId == null) {
        return false;
      }

      emit(AddProductState(product: defaultCubitProduct));
      return true;

    } else {
      print("Cannot add product: Missing required fields.");
      return false;
    }
  }
}
