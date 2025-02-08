import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rawaaj/services/outfit_services.dart';
import '../models/outfit_model.dart';
import '../databases/app_database.dart';
import '../utils/internet_connection_check.dart';

part 'outfit_state.dart';

class OutfitCubit extends Cubit<OutfitState> {
  OutfitCubit() : super(OutfitInitial());

  void fetchOutfitById(int id) async {
    try {
      emit(OutfitLoading());
      final isConnected = await isDeviceConnected();
      final Outfit? outfit;

      if(isConnected) {
        final outfitService = OutfitService();
        outfit = await outfitService.getOutfitById(id);
      } else {
        final db = AppDatabase.instance;
        outfit = await db.getOutfitById(id);
      }

      if (outfit == null) {
        throw Exception('Outfit with ID $id not found');
      }

      emit(OutfitLoaded(outfit: outfit));
    } catch (e) {
      emit(OutfitError(message: e.toString()));
    }
  }

  Future<void> toggleOutfitLike(int id) async {
    try {
      if (state is! OutfitLoaded) {
        throw Exception('Cannot toggle like - Outfit not loaded');
      }
      final outfit = (state as OutfitLoaded).outfit;
      final isConnected = await isDeviceConnected();

      if(isConnected) {
        final outfitService = OutfitService();
        outfitService.toggleOutfitLike(1, id);
        final updatedOutfit = outfit.copyWith(isLiked: !outfit.isLiked);
        emit(OutfitLoaded(outfit: updatedOutfit));
      }

    } catch (e) {
      emit(OutfitError(message: e.toString()));
    }
  }
}
