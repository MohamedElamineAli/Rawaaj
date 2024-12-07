import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rawaaj/widgets/header_bar.dart';

import '../widgets/bottom_nav_bar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderBar(title: "Map", isFiltered: false),

      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(36.68773,2.85546), // Center the map over London
          initialZoom: 15,
        ),
        children: [
          TileLayer( // Display map tiles from any source
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
            userAgentPackageName: 'com.example.app',
            // And many more recommended properties!
          ),
        ],
      ),
    );
  }
}
