import 'package:bloc/bloc.dart';
import '../utils/account_utils.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());

  Future<void> loadAccountInfo() async {
    emit(AccountLoading());
    try {
      final isLoggedIn = await AccountUtils.isLoggedIn();
      final userId = await AccountUtils.getUserId();
      final isShop = await AccountUtils.isShop();

      emit(AccountSuccess(isLoggedIn: isLoggedIn, userId: userId, isShop: isShop));
    } catch (e) {
      emit(AccountError("Failed to load account info"));
    }
  }

  Future<void> saveUser(int userId, bool isShop) async {
    emit(AccountLoading());
    try {
      await AccountUtils.saveUserIdAndIsShop(userId, isShop);
      emit(AccountSuccess(isLoggedIn: true, userId: userId, isShop: isShop));
    } catch (e) {
      emit(AccountError("Failed to save user data"));
    }
  }
}
