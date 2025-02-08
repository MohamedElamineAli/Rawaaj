import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../models/summarized_outfit_model.dart';
import '../databases/app_database.dart';
import '../services/outfit_services.dart';
import '../utils/internet_connection_check.dart';

part 'outfits_state.dart';

class OutfitsCubit extends Cubit<OutfitsState> {
  OutfitsCubit() : super(OutfitsList(outfitsMap: const {}));

  Future<void> fetchOutfits() async {
    try {
      final outfitService = OutfitService();

      final isConnected = await isDeviceConnected();

      final List<SummarizedOutfit> outfits;

      if (isConnected) {
        outfits = await outfitService.getAllOutfits();
      } else {
        outfits = [];
      }

      final currentMap = Map<String, List<SummarizedOutfit>>.from(
          (state as OutfitsList).outfitsMap);
      currentMap['all'] = outfits;

      emit(OutfitsList(outfitsMap: currentMap));
    } catch (e) {
      emit(OutfitsError(message: 'Failed to fetch outfits: $e'));
    }
  }

  Future<void> fetchOutfitsByContextType(String contextType) async {
    try {
      final isConnected = await isDeviceConnected();
      final List<SummarizedOutfit> outfits;
      // print(isConnected);

      if (isConnected) {
        final outfitService = OutfitService();
        outfits = await outfitService.getOutfitsByContextType(contextType, 1);
        print('outfits:');
        print(outfits);
      } else {
        final db = AppDatabase.instance;
        outfits = await db.getOutfitsByContextType(contextType);// 'isLiked' context Type
      }

      final currentMap = Map<String, List<SummarizedOutfit>>.from(
          (state as OutfitsList).outfitsMap);
      currentMap[contextType] = outfits;

      // print(currentMap);

      emit(OutfitsList(outfitsMap: currentMap));
    } catch (e) {
      emit(OutfitsError(message: 'Failed to fetch outfits: $e'));
    }
  }

  Future<void> toggleOutfitLike(int id) async {
    try {
      if (state is! OutfitsList) {
        throw Exception('Cannot toggle like - invalid state');
      }

      final currentMap = Map<String, List<SummarizedOutfit>>.from(
          (state as OutfitsList).outfitsMap);

      currentMap.forEach((key, outfitList) {
        for (int i = 0; i < outfitList.length; i++) {
          if (outfitList[i].id == id) {
            outfitList[i] =
                outfitList[i].copyWith(isLiked: !outfitList[i].isLiked);
          }
        }
      });

      emit(OutfitsList(outfitsMap: currentMap));

      final db = AppDatabase.instance;
      await db.toggleOutfitLike(id);
    } catch (e) {
      emit(OutfitsError(message: 'Failed to toggle like: $e'));
    }
  }

  Future<void> toggleOutfitLikeWithoutDB(int id) async {
    try {
      if (state is! OutfitsList) {
        throw Exception('Cannot toggle like - invalid state');
      }

      final currentMap = Map<String, List<SummarizedOutfit>>.from(
          (state as OutfitsList).outfitsMap);

      currentMap.forEach((key, outfitList) {
        for (int i = 0; i < outfitList.length; i++) {
          if (outfitList[i].id == id) {
            outfitList[i] =
                outfitList[i].copyWith(isLiked: !outfitList[i].isLiked);
          }
        }
      });

      emit(OutfitsList(outfitsMap: currentMap));
    } catch (e) {
      emit(OutfitsError(message: 'Failed to toggle like: $e'));
    }
  }
}
