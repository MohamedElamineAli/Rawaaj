import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../models/summarized_product_model.dart';
import '../databases/app_database.dart';
import '../services/product_service.dart';
import '../utils/internet_connection_check.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsList(productsMap: const {}));

  Future<void> fetchProducts() async {
    try {
      var currentMap = Map<String, List<SummarizedProduct>>.from(
          (state as ProductsList).productsMap);

      if (currentMap['all'] != null) {
        if (currentMap['all']!.isNotEmpty) {
          return;
        }
      }

      final productService = ProductService();

      final isConnected = await isDeviceConnected();

      final List<SummarizedProduct> products;

      if (isConnected) {
        products = await productService.getAllProducts();
      } else {
        products = [];
      }

      currentMap['all'] = products;

      emit(ProductsList(productsMap: currentMap));
    } catch (e) {
      emit(ProductsError(message: 'Failed to fetch products: $e'));
    }
  }

  Future<void> fetchProductsByContextType(String contextType) async {
    try {
      final List<SummarizedProduct> products;
      final isConnected = await isDeviceConnected();

      if (isConnected) {
        final productService = ProductService();
        products =
            await productService.getProductsByContextType(contextType, 1);
      } else {
        final db = AppDatabase.instance;
        products = await db
            .getProductsByContextType(contextType); // 'isLiked' context Type
      }

      var currentMap = Map<String, List<SummarizedProduct>>.from(
          (state as ProductsList).productsMap);
      currentMap[contextType] = products;

      emit(ProductsList(productsMap: currentMap));
    } catch (e) {
      emit(ProductsError(message: 'Failed to fetch products: $e'));
    }
  }

  Future<void> fetchProductsByCategoryId(int categoryId) async {
    try {
      final List<SummarizedProduct> products;
      final isConnected = await isDeviceConnected();

      if (isConnected) {
        final productService = ProductService();
        products = await productService.getProductsByFilters(categoryId: categoryId);
      } else {
        products = [];
      }

      var currentMap = Map<String, List<SummarizedProduct>>.from(
          (state as ProductsList).productsMap);
      currentMap['category_$categoryId'] = products;

      emit(ProductsList(productsMap: currentMap));
    } catch (e) {
      emit(ProductsError(message: 'Failed to fetch products: $e'));
    }
  }

  Future<void> fetchProductsByShopId(int shopId) async {
    try {
      final List<SummarizedProduct> products;
      final isConnected = await isDeviceConnected();

      if (isConnected) {
        final productService = ProductService();
        products = await productService.getProductsByShopId(shopId);
      } else {
        products = [];
      }

      var currentMap = Map<String, List<SummarizedProduct>>.from(
          (state as ProductsList).productsMap);
      currentMap['shop'] = products;

      emit(ProductsList(productsMap: currentMap));
    } catch (e) {
      emit(ProductsError(message: 'Failed to fetch products: $e'));
    }
  }

  Future<void> fetchProductsBySearch(String keyword) async {
    try {
      final List<SummarizedProduct> products;
      final isConnected = await isDeviceConnected();

      if (isConnected) {
        final productService = ProductService();
        products = await productService.searchProductsByDescription(keyword);
      } else {
        products = [];
      }

      var currentMap = Map<String, List<SummarizedProduct>>.from(
          (state as ProductsList).productsMap);
      currentMap['search'] = products;

      emit(ProductsList(productsMap: currentMap));
    } catch (e) {
      emit(ProductsError(message: 'Failed to fetch products: $e'));
    }
  }

  Future<void> fetchProductsByFilter(
      int size, int color, double lower, double upper, int sortType) async {
    try {
      final List<SummarizedProduct> products;
      final isConnected = await isDeviceConnected();

      String sortTypeKey(int sortType) {
        switch (sortType) {
          case 2:
            return 'desc';
          default:
            return 'asc';
        }
      }

      if (isConnected) {
        final productService = ProductService();
        products = await productService.getProductsByFilters(
          sizeIdList: [size + 1],
          colorIdList: [color + 1],
          priceRange: [lower, upper],
          priceOrderType: sortTypeKey(sortType),
        );
      } else {
        products = [];
      }

      print(products);

      var currentMap = Map<String, List<SummarizedProduct>>.from(
          (state as ProductsList).productsMap);
      currentMap['filter'] = products;

      emit(ProductsList(productsMap: currentMap));
    } catch (e) {
      emit(ProductsError(message: 'Failed to fetch products: $e'));
    }
  }

  Future<void> fetchProductsByIds(List<int> ids) async {
    try {
      var currentMap = Map<String, List<SummarizedProduct>>.from(
          (state as ProductsList).productsMap);

      final products = currentMap['all']
          ?.where((product) => ids.contains(product.id))
          .toList();

      currentMap['selected'] = products ?? [];

      emit(ProductsList(productsMap: currentMap));
    } catch (e) {
      emit(ProductsError(message: 'Failed to fetch products: $e'));
    }
  }
}
