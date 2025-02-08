part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsList extends ProductsState {
  final Map<String, List<SummarizedProduct>> productsMap;

  ProductsList({required this.productsMap});
}

final class ProductsError extends ProductsState {
  final String message;

  ProductsError({required this.message});
}
