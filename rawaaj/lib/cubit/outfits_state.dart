part of 'outfits_cubit.dart';

@immutable
sealed class OutfitsState {}

final class OutfitsList extends OutfitsState {
  final Map<String, List<SummarizedOutfit>> outfitsMap;

  OutfitsList({required this.outfitsMap});
}

final class OutfitsError extends OutfitsState {
  final String message;

  OutfitsError({required this.message});
}
