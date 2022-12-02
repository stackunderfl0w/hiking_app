

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:hiking_app/Classes/HikeData.dart';
import 'Classes/UserData.dart';

import 'location.dart';
import 'map.dart';

//this feels awful but it works. Create a function pointer callback by main that begins a hike, public to files that include this one
late var CHANGE_MAIN_VIEW_CALLBACK;

HikeData globalCurrentHike=HikeData.draft(title: "Null", points: [LatLng(0,0)]);

class Hike extends StatefulWidget {
  const Hike({Key? key}) : super(key: key);


  @override
  _HikeState createState() => _HikeState();
}

class _HikeState extends State<Hike> {
  int page=0;

  late final Timer _timer;
  void initState() {
    super.initState();
    final_points=[current_LatLng,current_LatLng];
    final_times=[current_location.time!/1000];
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
      var kmDist=const Distance().distance(current_LatLng, final_points[final_points.length-2])/1000;
      final_points.last=current_LatLng;
      if(kmDist>.1){
        final_points.add(current_LatLng);
        final_times.add(current_location.time!/1000);
      }
    });
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
    @override
  Widget build(BuildContext context){
    if(page==0){
      return Scaffold(
        body:Container(
          color: const Color.fromARGB(103, 0, 250, 67), //this controls the backround color
          child: Center( //
            child: FullMap(showUserLocation: true,forceFollowUserLocation: true ,defaultZoom: 13,lineLayer: true,showElevation: true, points: globalCurrentHike.points,secondary_points: final_points,),
          ),
        ),
        floatingActionButton:FloatingActionButton(
          child: const Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              _timer.cancel();
              final_points.removeLast();
              page=1;
              globalCurrentHike=HikeData(title: globalCurrentHike.title, points: final_points, difficulty: 0, private: true, comments: false, owned: true,times: final_times);
            });
          },
        ),
      );
    }
    else{
      return Scaffold(
        backgroundColor: Colors.green,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 0),
            // centered list in the middle of the page with the stats, a public/private toggle button, and the publish button at the bottom
            Text("${globalCurrentHike.title} Completed!",textAlign: TextAlign.center,    style: const TextStyle(fontSize: 25),),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.lightGreenAccent,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),

                      child:Column(
                        children: [
                          const Text("Stats", style: TextStyle(fontSize: 25),),
                          Text("Distance traveled: ${(globalCurrentHike.length).toStringAsFixed(2)}km", style: TextStyle(fontSize: 25),),
                          Text("Time: ${_printDuration(Duration(seconds:(globalCurrentHike.times.last-globalCurrentHike.times.first).toInt()))}", style: TextStyle(fontSize: 25),),
                          Text("Average pace: ${(globalCurrentHike.length/(globalCurrentHike.times.last-globalCurrentHike.times.first)*1000).toStringAsFixed(1)}m/s", style: TextStyle(fontSize: 25),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          SizedBox(width: 50,),
                          Text("Make Hike Private?", style: TextStyle(fontSize: 25),),
                          SizedBox(width: 10,),
                          Checkbox(value: globalCurrentHike.private, onChanged:(bool? value){setState(() {
                            globalCurrentHike.private=value!;
                          });},),
                        ]
                      )
                    ),
                  ],

                )

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: (){
                  print("publish",);
                  globalUserHikesList.add(globalCurrentHike);
                  CHANGE_MAIN_VIEW_CALLBACK(1);
              },
                child: const Text("Publish", style: TextStyle(fontSize: 25),))
            ),
            const SizedBox(height: 0)
          ],
        ),
      );
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