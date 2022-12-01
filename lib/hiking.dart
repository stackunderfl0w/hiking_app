

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:hiking_app/Classes/HikeData.dart';

import 'location.dart';
import 'map.dart';

//this feels awful but it works. Create a function pointer callback by main that begins a hike, public to files that include this one
late var beginHikingCallback;

HikeData globalCurrentHike=HikeData.draft(title: "Null", points: [LatLng(0,0)]);

class Hike extends StatefulWidget {
  const Hike({Key? key}) : super(key: key);


  @override
  _HikeState createState() => _HikeState();
}

class _HikeState extends State<Hike> {
  int page=0;
  List<LatLng> hiking_path=globalCurrentHike.points;
  int hiking_index=0;
  List<LatLng> final_points=[current_LatLng,current_LatLng];
  List<double> final_times=[current_location.time!];

  late final Timer _timer;
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
      var kmDist=const Distance().distance(current_LatLng, final_points[final_points.length-2])/1000;
      final_points.last=current_LatLng;
      if(kmDist>.1){
        final_points.add(current_LatLng);
        final_times.add(current_location.time!);
      }
    });
  }


    @override
  Widget build(BuildContext context){
    if(page==0){
      return Scaffold(
        body:Container(
          color: Color.fromARGB(103, 0, 250, 67), //this controls the backround color
          child: Center( //
            child: FullMap(showUserLocation: true,forceFollowUserLocation: true ,defaultZoom: 13,lineLayer: true,showElevation: true, points: globalCurrentHike.points,secondary_points: final_points,),
          ),
        ),
        floatingActionButton:FloatingActionButton(
          child: const Icon(Icons.cancel),
          onPressed: () {
            setState(() {page=1;final_points.removeLast();});
          },
        ),
      );
    }
    else{
      return Container();
    }
  }

}

/*class Hike_Complete_Page extends StatefulWidget {
  const Hike_Complete_Page({Key? key}) : super(key: key);

  @override
  _Hike_Complete_PageState createState() => _Hike_Complete_PageState();
}

class _Hike_Complete_PageState extends State<Hike_Complete_Page> {
  @override
  Widget build(BuildContext context) {

  }
}*/