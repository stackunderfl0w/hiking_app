
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_line_editor/dragmarker.dart';
import 'package:flutter_map_line_editor/polyeditor.dart';
import 'location.dart';


final mapController = MapController();
final List<LatLng> cords=[];
List<Polyline> polyLines = [];
var testPolyline = Polyline(color: Colors.deepOrange, points: []);


class FullMap extends StatefulWidget {
  bool lineLayer=false;
  bool lineEditor=false;
  bool showUserLocation=false;
  FullMap({Key? key, this.lineLayer=false, this.lineEditor=false, this.showUserLocation=false}) : super(key: key);

  @override
  State<FullMap> createState() => _FullMapState();
}

class _FullMapState extends State<FullMap> {
  late PolyEditor polyEditor;
  final mapController = MapController();
  late final Timer _timer;


  List<Polyline> polyLines = [];
  @override
  void initState() {
    super.initState();
    polyEditor = PolyEditor(
      addClosePathMarker: false,
      points: testPolyline.points,
      pointIcon: const Icon(Icons.crop_square, size: 23),
      intermediateIcon: const Icon(Icons.lens, size: 15, color: Colors.grey),
      callbackRefresh: () {print("polyedipolyLinest setstate"); setState(() {} ); },
    );
    polyLines.add(testPolyline);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {setState(() {});});
  }
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }


  @override
  Widget build(BuildContext context) {
    bool lineLayer=widget.lineLayer;
    bool lineEditor=widget.lineEditor;
    bool showUserLocation=widget.showUserLocation;
    return Scaffold(
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          absorbPanEventsOnScrollables: false,
          center: LatLng(51.5, -0.09),
          zoom: 5,
          onTap: (_, ll) {
            polyEditor.add(testPolyline.points, ll);
          },
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
          if (lineEditor == true) ...[
            PolylineLayer(polylines: polyLines),
            DragMarkers(markers:  polyEditor.edit()),
          ]
          else if (lineLayer == true) ...[
            PolylineLayer(
              polylineCulling: false,
              polylines: [
                Polyline(
                  points:  [LatLng(30, 40), LatLng(20, 50), LatLng(25, 45),],
                  color: Colors.blue,
                ),
              ],
            ),
          ],
          if (showUserLocation == true) ...[
            MarkerLayer(
              markers: [
                Marker(
                  point: current_LatLng,
                  width: 30,
                  height: 30,
                  builder: (context) => Container(decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle,),),
                ),
              ],
            ),
          ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.replay),
        onPressed: () {
          //mapController.move(LatLng(current_location.latitude!,current_location.longitude!), 11);
          mapController.moveAndRotate(current_LatLng, 17,0);
        },
      ),
    );
  }
}

