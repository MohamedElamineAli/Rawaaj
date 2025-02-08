import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../cubit/map_cubit.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            if (state is MapInitial || state is MapLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MapError) {
              return Center(child: Text(state.message));
            } else if (state is MapLoaded) {
              return FlutterMap(
                mapController: context.read<MapCubit>().mapController,
                options: MapOptions(
                  initialCenter: LatLng(
                    state.currentPosition!.latitude,
                    state.currentPosition!.longitude,
                  ),
                  initialZoom: 15,
                  initialRotation: state.direction,
                  onMapReady: () => context.read<MapCubit>().onMapReady(),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: LatLng(36.68473, 2.85646),
                        // LatLng(
                        //   state.currentPosition!.latitude,
                        //   state.currentPosition!.longitude,
                        // ),
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: state.targetedShops.map((shop) {
                      return Marker(
                        width: 80,
                        height: 50.0,
                        point: shop['position'],
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 120), // Set a maximum width
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Ensure the column takes minimum space
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                color: Colors.green,
                                size: 30,
                              ),
                              Flexible(
                                child: Text(
                                  shop['name'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis, // Ellipsize if text is too long
                                  maxLines: 1, // Limit to one line
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
    );
  }

  final List<Map<String, dynamic>> shops = [
    {
      'name': 'Shop 1',
      'position': LatLng(36.68873, 2.85646),
    },
    {
      'name': 'Shop 2',
      'position': LatLng(36.68673, 2.85446),
    },
  ];
}
