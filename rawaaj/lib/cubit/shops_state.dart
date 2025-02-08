part of 'shops_cubit.dart';

@immutable
sealed class ShopsState {}

final class ShopsList extends ShopsState {
  final List<SummarizedShop> shops;

  ShopsList({required this.shops});
}

final class ShopsError extends ShopsState {
  final String message;

  ShopsError({required this.message});
}