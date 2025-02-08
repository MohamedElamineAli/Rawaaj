import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../models/shop_model.dart';
import '../databases/app_database.dart';
import '../services/user_account_service.dart';
import '../utils/internet_connection_check.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  void fetchShopById(int id) async {
    try {
      print("fetch_shop");
      emit(ShopLoading());
      final isConnected = await isDeviceConnected();
      final Shop? shop;

      if (isConnected) {
        final userAccountService = UserAccountService();
        shop = await userAccountService.getShopById(id);
      } else {
        final db = AppDatabase.instance;
        shop = await db.getShopById(id);
      }

      if (shop == null) {
        throw Exception('Shop with ID $id not found');
      }

      emit(ShopLoaded(shop: shop));
    } catch (e) {
      emit(ShopError(message: e.toString()));
    }
  }

  Future<void> toggleFollow(int shopId) async {
    try {
      if (state is! ShopLoaded) {
        throw Exception('Cannot toggle like - product not loaded');
      }
      final isConnected = await isDeviceConnected();
      if (isConnected) {
        final userAccountService = UserAccountService();
        final isDone = await userAccountService.toggleFollowing(1, shopId);
        if (isDone) {
          final shop = (state as ShopLoaded).shop;
          final updatedProduct = shop.copyWith(
              isFollowed: !shop.isFollowed,
              followersNum: shop.isFollowed
                  ? shop.followersNum - 1
                  : shop.followersNum + 1);

          emit(ShopLoaded(shop: updatedProduct));
        }
      }
    } catch (e) {
      emit(ShopError(message: e.toString()));
    }
  }
}
