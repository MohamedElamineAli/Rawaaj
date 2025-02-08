part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapLoaded extends MapState {
  final Position? currentPosition;
  final double direction;
  final bool isMapReady;
  final List<Map<String, dynamic>> targetedShops; // List of targeted shops with name and position

  MapLoaded({
    required this.currentPosition,
    required this.direction,
    required this.isMapReady,
    this.targetedShops = const [], // Initialize as empty list
  });
}

final class MapError extends MapState {
  final String message;

  MapError({required this.message});
}