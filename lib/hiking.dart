

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
  List<LatLng> hiking_path=globalCurrentHike.points;
  int hiking_index=0;
  List<LatLng> final_points=[];
  List<double> final_times=[];

  late final Timer _timer;
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {});
      final_points.add(current_LatLng);
      final_times.add(current_location.time!);
      var km_dist=Distance().distance(current_LatLng, hiking_path[hiking_index])/1000;
      if(km_dist<.1){
        hiking_index++;
        if(hiking_index==hiking_path.length){
          //end_hike
          print("INCREASE HIKING INDEX\n\n");
        }
      }
    });

  }


    @override
  Widget build(BuildContext context) {
      return Container(
        color: Color.fromARGB(103, 0, 250, 67), //this controls the backround color
        child: Center( //
          child: FullMap(showUserLocation: true,forceFollowUserLocation: true ,defaultZoom: 13,lineLayer: true,showElevation: true, points: globalCurrentHike.points,),
        )
    );
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