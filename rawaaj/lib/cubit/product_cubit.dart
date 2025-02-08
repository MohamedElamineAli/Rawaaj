import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rawaaj/services/product_service.dart';
import '../models/product_model.dart';
import '../databases/app_database.dart';
import '../utils/internet_connection_check.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void fetchProductById(int id) async {
    try {
      emit(ProductLoading());
      final isConnected = await isDeviceConnected();
      final Product? product;

      if(isConnected) {
        final productService = ProductService();
        product = await productService.getProductById(id);
      }else {
        final db = AppDatabase.instance;
        product = await db.getProductById(id);
      }

      if (product == null) {
        throw Exception('Product with ID $id not found');
      }

      emit(ProductLoaded(product: product));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> toggleProductLike(int id) async {
    try {
      if (state is! ProductLoaded) {
        throw Exception('Cannot toggle like - product not loaded');
      }
      final product = (state as ProductLoaded).product;
      final isConnected = await isDeviceConnected();

      if(isConnected) {
        final productService = ProductService();
        productService.toggleProductLike(1, id);
        final updatedProduct = product.copyWith(isLiked: !product.isLiked);
        emit(ProductLoaded(product: updatedProduct));
      }

    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
