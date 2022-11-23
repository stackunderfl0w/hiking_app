import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Classes/HikeData.dart';
import 'package:latlong2/latlong.dart';
import 'map.dart';

List<HikeData> draft_hikes=[HikeData.draft(title:"Draft Hike 1", points:[LatLng(0, 0)])];

class Planner extends StatefulWidget {
  const Planner({Key? key}) : super(key: key);

  @override
  _PlannerState createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  List<LatLng> points=[];

  int page=0;
  @override
  Widget build(BuildContext context) {
    if(page==0){
      return Scaffold(
        backgroundColor: Colors.grey,
          body:SingleChildScrollView(
            child:Container(
              padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
              child: Column(
                children: [
                  for ( var i in draft_hikes ) ...[
                    GestureDetector(
                      onTap: () { setState(() {page=1; points=i.points;}); },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                        ),
                      width: double.infinity,
                      height: 75,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Center(
                        child: Text(i.title, style: TextStyle(fontSize: 25),),
                      ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ]
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            setState(() {page=1;});
          },
        ),
      );
    }
    else{
      return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: FullMap(defaultZoom: 13,lineEditor: true,editor_points: points,),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            draft_hikes.add(HikeData.draft(title:"title${Random().nextInt(999)}",points:points));
            setState(() {page=0;});
            // print(points);
            points=[];
          },
        ),
      );
    }
  }
}
