part of 'add_outfit_cubit.dart';

class AddOutfitState extends Equatable {
  final Outfit outfit;
  final bool isLoading;

  const AddOutfitState({required this.outfit, this.isLoading = false});

  AddOutfitState copyWith({
    int? id,
    File? outfitImage,
    int? numOfLikes,
    bool? isLiked,
    String? description,
    double? totalPrice,
    List<int>? outfitComponents,
  }) {
    return AddOutfitState(
      outfit: outfit.copyWith(
        id: id,
        outfitImage: outfitImage,
        numOfLikes: numOfLikes,
        isLiked: isLiked,
        description: description,
        totalPrice: totalPrice,
        outfitComponents: outfitComponents,
      ),
    );
  }

  @override
  List<Object?> get props => [outfit, isLoading];
}
