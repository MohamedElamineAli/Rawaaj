part of 'outfit_cubit.dart';

@immutable
sealed class OutfitState {}

final class OutfitInitial extends OutfitState {}

final class OutfitLoading extends OutfitState {}

final class OutfitLoaded extends OutfitState {
  final Outfit outfit;

  OutfitLoaded({required this.outfit});
}

final class OutfitError extends OutfitState {
  final String message;

  OutfitError({required this.message});
}