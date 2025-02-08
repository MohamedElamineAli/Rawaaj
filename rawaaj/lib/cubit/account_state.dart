part of 'account_cubit.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final bool isLoggedIn;
  final int? userId;
  final bool? isShop;

  AccountSuccess({required this.isLoggedIn, this.userId, this.isShop});
}

class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
}
