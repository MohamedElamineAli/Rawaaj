part of 'shop_cubit.dart';

@immutable
sealed class ShopState {}

final class ShopInitial extends ShopState {}

final class ShopLoading extends ShopState {}

final class ShopLoaded extends ShopState {
  final Shop shop;

  ShopLoaded({required this.shop});
}

final class ShopError extends ShopState {
  final String message;

  ShopError({required this.message});
}