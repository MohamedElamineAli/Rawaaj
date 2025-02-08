part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {
  final String? wilaya;
  final String? daira;
  final List<String>? wilayasList;

  LocationLoading({
    this.wilaya,
    this.daira,
    this.wilayasList
  });
}

class LocationLoaded extends LocationState {
  final String wilaya;
  final String daira;
  final String commune;
  final String? address;

  LocationLoaded({
    required this.wilaya,
    required this.daira,
    required this.commune,
    this.address
  });
}

class LocationUpdated extends LocationState {
  final String wilaya;
  final String daira;
  final String commune;
  final String? address;

  LocationUpdated({
    required this.wilaya,
    required this.daira,
    required this.commune,
    this.address
  });
}
