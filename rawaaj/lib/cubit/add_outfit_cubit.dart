import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rawaaj/databases/database_consts.dart';
import 'package:rawaaj/services/outfit_services.dart';
import '../constants/default_cubit_product.dart';
import '../models/outfit_model.dart';

part 'add_outfit_state.dart';

class AddOutfitCubit extends Cubit<AddOutfitState> {
  AddOutfitCubit(Outfit outfit) : super(AddOutfitState(outfit: outfit));

  void updateOutfitImage(File outfitImage) {
    emit(state.copyWith(outfitImage: outfitImage));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateTotalPrice(double totalPrice) {
    emit(state.copyWith(totalPrice: totalPrice));
  }

  void updateOutfitComponents(List<int> outfitComponents) {
    emit(state.copyWith(outfitComponents: outfitComponents));
  }

  /// Checks if all required fields are filled and `outfitComponents` size > 2
  bool canAddOutfit() {
    final outfit = state.outfit;
    return outfit.outfitImage.path.isNotEmpty &&
        outfit.description.isNotEmpty &&
        outfit.outfitComponents != null &&
        outfit.outfitComponents!.length >= 2 &&
        outfit.totalPrice > 0;
  }

  /// Add button logic (can include saving to backend or triggering next steps)
  Future<bool> addOutfit() async {
    if (canAddOutfit()) {
      emit(AddOutfitState(outfit: state.outfit, isLoading: true));
      final outfitService = OutfitService();
      final outfitId = await outfitService.addOutfit(state.outfit);
      if(outfitId == null) {
        return false;
      }
      emit(AddOutfitState(outfit: defaultCubitOutfit, isLoading: false));
      print("Outfit added");
      return true;
    } else {
      print("Cannot add outfit: Missing required fields or invalid components.");
      return false;
    }
  }
}
