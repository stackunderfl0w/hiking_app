
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:hiking_app/hiking.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_line_editor/dragmarker.dart';
import 'package:flutter_map_line_editor/polyeditor.dart';
import 'location.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


final mapController = MapController();
final List<LatLng> cords=[];
LatLng globalCurrentViewLocation=LatLng(44.55534, -123.27086);
//double globalCurrentZoom=12;
List<Polyline> polyLines = [];

class FullMap extends StatefulWidget {
  bool lineLayer;
  bool lineEditor;
  List<LatLng>? points;
  List<LatLng>? secondary_points;
  List<Marker>? markers;
  bool showUserLocation;
  double defaultZoom;
  bool forceFollowUserLocation;
  bool showElevation;

  FullMap({Key? key, this.lineLayer=false, this.lineEditor=false, this.points,this.secondary_points ,this.showUserLocation=false,this.forceFollowUserLocation=false,this.showElevation=false, this.markers, this.defaultZoom=15}) : super(key: key);

  @override
  State<FullMap> createState() => _FullMapState();
}

class _FullMapState extends State<FullMap> {
  late PolyEditor polyEditor;
  final mapController = MapController();
  late final Timer _timer;
  var testPolyline = Polyline(color: Colors.deepOrange, points: []);


  List<Polyline> polyLines = [];
  @override
  void initState() {
    super.initState();
    if(widget.lineEditor){
      testPolyline=Polyline(color: Colors.deepOrange, points: widget.points!);
      polyEditor = PolyEditor(
        addClosePathMarker: false,
        points:testPolyline.points,
        pointIcon: const Icon(Icons.crop_square, size: 23),
        intermediateIcon: const Icon(Icons.lens, size: 15, color: Colors.grey),
        callbackRefresh: () {print("polyedipolyLinest setstate"); setState(() {} ); },
      );
      polyLines.add(testPolyline);
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
      print(globalCurrentViewLocation);
      print(current_location.altitude);
    });
  }
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  double current_speed(){
    double length=0;
    for(var i=1; i<final_points.length; i++) {
      length+=Distance().distance(final_points[i], final_points[i-1])/1000;
    }

    return (length/((current_location.time!/1000)-final_times.first)*1000);
  }
  @override
  Widget build(BuildContext context) {
    bool lineLayer=widget.lineLayer;
    bool lineEditor=widget.lineEditor;
    bool showUserLocation=widget.showUserLocation;
    bool forceFollowUserLocation=widget.forceFollowUserLocation;
    bool showElevation=widget.showElevation;
    double defaultZoom=widget.defaultZoom;
    List<LatLng>? points=widget.points;
    List<LatLng>? secondary_points=widget.secondary_points;
    List<Marker>? marks=widget.markers;

    if(lineEditor&&widget.points == null){
      lineEditor=false;
      print("ERROR: LINE EDITOR REQUESTED BUT NO TARGET ARRAY PROVIDED");
    }
    if(lineLayer&&widget.points == null){
      lineLayer=false;
      print("ERROR: LINE Layer REQUESTED BUT NO TARGET ARRAY PROVIDED");
    }
    //print("create map centered at");
    //print(globalCurrentViewLocation);
    return Scaffold(
      body:Stack(children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
              absorbPanEventsOnScrollables: false,
              center: globalCurrentViewLocation,
              zoom: defaultZoom,
              maxZoom: 18,
              minZoom: 5,
              onTap: (_, ll) {
                if(lineEditor){
                  polyEditor.add(testPolyline.points, ll);
                  print(testPolyline.points);
                }
              },
              onPositionChanged: (MapPosition position, bool hasGesture){
                globalCurrentViewLocation=position.center!;
              }
          ),
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: 'OpenStreetMap contributors',
              onSourceTapped: () {},
            ),
          ],
          children: [
            /*TileLayer(
            urlTemplate:
            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),*/
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              tileProvider: FMTC.instance('mapcache').getTileProvider(),
              maxZoom: 20,
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              keepBuffer: 5,
              backgroundColor: const Color(0xFFaad3df),
            ),
            if (lineEditor == true) ...[
              PolylineLayer(polylines: [testPolyline]),
              DragMarkers(markers:  polyEditor.edit()),
            ]
            else if (lineLayer == true) ...[
              PolylineLayer(
                polylineCulling: false,
                polylines: [
                  Polyline(
                      points: points!,
                      color: Colors.blue,
                      strokeWidth:5,
                  ),
                ],
              ),
             if (secondary_points != null) ...[
               PolylineLayer(
                 polylineCulling: false,
                 polylines: [
                   Polyline(
                     points: secondary_points,
                     color: Colors.green,
                     strokeWidth:5,
                   ),
                 ],
               ),
             ]

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
            ],
            if (marks != null) ...[
              MarkerLayer(
                markers: marks,
              ),
            ]
          ],
        ),
        !showElevation? Container():Container(
          alignment: Alignment(1.0, -.5),
          child:Text("ELEVATION: ${(current_location.altitude!*3.281).toStringAsFixed(0)}ft"
              "\nAverage speed: ${current_speed().toStringAsFixed(1)}m/s",
            style: TextStyle(
                color: Colors.blue,
                backgroundColor: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22.0),
          ),
        )
      ],),
      floatingActionButton: forceFollowUserLocation ? Container() : FloatingActionButton(
        child: const Icon(Icons.replay),
        onPressed: () {
        //mapController.move(LatLng(current_location.latitude!,current_location.longitude!), 11);
        mapController.moveAndRotate(current_LatLng, defaultZoom,0);
        },
      ),
    );
  }
}

Future<void> init_cache() async {
  FlutterMapTileCaching.initialise(await RootDirectory.normalCache);

  FMTC.instance; // Now available from anywhere
  String fileName = "mapcache.fmtc";
  String dir = (await getApplicationDocumentsDirectory()).path;
  String savePath = '$dir/$fileName';
  print("filename=$savePath");

//for a directory: await Directory(savePath).exists();
  StoreDirectory store;
  bool wait = true;
  if (await File(savePath).exists()) {
    print("outputFilePath");
    FMTC.instance.rootDirectory.import.manual(File(savePath));
    wait=false;
  } else {
    print("creating new store");
    store = FMTC.instance('mapcache');
    await store.manage.createAsync(); // Create the store if necessary
    final region = CircleRegion(
        LatLng(44.55534, -123.27086),
        50
    ).toDownloadable(1, 13, TileLayer(urlTemplate:
    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',)
    );
    FMTC
        .instance('mapcache')
        .download
        .startForeground(region: region)
        .listen(
          (dp) {
        debugPrint("Dowloading..."); // Works
      },
      onDone: () async {
        debugPrint("onDone");
        FMTC
            .instance('mapcache')
            .export
            .manual(File(savePath));
        wait = false;
      },
      onError: (err) {
        debugPrint("onError");
      },
    );
    while (wait) {
      print("Waiting on map to download");
      await Future.delayed(Duration(seconds: 1));
    }
  }

}
