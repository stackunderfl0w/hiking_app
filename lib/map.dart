import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';

class map extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 5,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: () {},
        ),
      ],
      children: [
        TileLayer(
          urlTemplate:
          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        PolylineLayer(
          polylineCulling: false,
          polylines: [
            Polyline(
              points: [LatLng(30, 40), LatLng(20, 50), LatLng(25, 45),],
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}

class lined_map extends StatelessWidget {
  const lined_map({Key? key,required this.cords}) : super(key: key);
  final List<LatLng> cords;
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 5,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: () {},
        ),
      ],
      children: [
        TileLayer(
          urlTemplate:
          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        PolylineLayer(
          polylineCulling: false,
          polylines: [
            Polyline(
              points: cords,
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}