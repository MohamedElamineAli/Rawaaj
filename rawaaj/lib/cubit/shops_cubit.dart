import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rawaaj/services/user_account_service.dart';
import '../models/summarized_shop_model.dart';
import '../databases/app_database.dart';
import '../utils/internet_connection_check.dart';

part 'shops_state.dart';

class ShopsCubit extends Cubit<ShopsState> {
  ShopsCubit() : super(ShopsList(shops: []));

  Future<void> fetchShops() async {
    try {
      final isConnected = await isDeviceConnected();
      final List<SummarizedShop> shops;

      if(isConnected) {
        final userAccountService = UserAccountService();
        shops = await userAccountService.getFollowedShops(1);
      } else {
        final db = AppDatabase.instance;
        shops = await db.getAllShops();
      }

      emit(ShopsList(shops: shops));
    } catch (e) {
      emit(ShopsError(message: 'Failed to fetch shops: $e'));
    }
  }
}
