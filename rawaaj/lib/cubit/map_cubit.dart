import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapController _mapController = MapController();
  StreamSubscription<Position>? _positionStreamSubscription;
  double _direction = 0;
  bool _isMapReady = false;
  List<Map<String, dynamic>> _targetedShops =
      []; // List of targeted shops with name and position

  MapController get mapController => _mapController;

  MapCubit() : super(MapInitial()) {
    _initLocationService();
    _initCompass();
  }

  bool isTargetedShopsEmpty() {
    return _targetedShops.isEmpty;
  }

  Future<void> _initLocationService() async {
    emit(MapLoading());

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(MapError(message: 'Location services are disabled.'));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(MapError(message: 'Location permissions are denied'));
        return;
      }
    }

    // Get initial position
    Position currentPosition = await Geolocator.getCurrentPosition();

    // Start location stream
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      if (_isMapReady) {
        emit(MapLoaded(
          currentPosition: position,
          direction: _direction,
          isMapReady: _isMapReady,
          targetedShops: _targetedShops, // Pass the list of targeted shops
        ));
        _mapController.move(
          const LatLng(36.68673, 2.85846),
          // LatLng(position.latitude, position.longitude),
          _mapController.camera.zoom,
        );
      }
    });

    emit(MapLoaded(
      currentPosition: currentPosition,
      direction: _direction,
      isMapReady: _isMapReady,
      targetedShops: _targetedShops, // Pass the list of targeted shops
    ));
  }

  void _initCompass() {
    FlutterCompass.events?.listen((CompassEvent event) {
      if (_isMapReady) {
        _direction = event.heading ?? 0;
        _mapController.rotate(_direction);
        emit(MapLoaded(
          currentPosition: (state as MapLoaded).currentPosition,
          direction: _direction,
          isMapReady: _isMapReady,
          targetedShops: _targetedShops, // Pass the list of targeted shops
        ));
      }
    });
  }

  void _initShopPositions() {
    if(_targetedShops.isNotEmpty) {
      return;
    }

    _targetedShops = [
      {
        'name': 'Shop 1',
        'position': LatLng(36.68873, 2.85646),
      },
      {
        'name': 'Shop 2',
        'position': LatLng(36.68673, 2.85446),
      },
    ];

    emit(MapLoaded(
      currentPosition: (state as MapLoaded).currentPosition,
      direction: _direction,
      isMapReady: _isMapReady,
      targetedShops: _targetedShops, // Update the list of targeted shops
    ));
  }

  void onMapReady() {
    _isMapReady = true;
    emit(MapLoaded(
      currentPosition: (state as MapLoaded).currentPosition,
      direction: _direction,
      isMapReady: _isMapReady,
      targetedShops: _targetedShops, // Pass the list of targeted shops
    ));

    _initShopPositions();
  }

  void setTargetShop(String name, double long, double lat) {
    _targetedShops = [
      {
        'name': name,
        'position': LatLng(long, lat),
      }
    ];
  }

  @override
  Future<void> close() {
    _positionStreamSubscription?.cancel();
    return super.close();
  }
}
