import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Classes/HikeData.dart';
import 'package:latlong2/latlong.dart';
import 'map.dart';

List<HikeDraft> draft_hikes=[HikeDraft("Draft Hike 1", [LatLng(0, 0)])];

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
        backgroundColor: Colors.greenAccent,
        body:SingleChildScrollView(
          child:Container(
            padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
            child: Column(
              children: [
                for ( var i in draft_hikes ) GestureDetector(
                  onTap: () { setState(() {page=1; points=i.points;}); },
                  child: Container(
                    child: Text(i.title),
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                    decoration: const BoxDecoration(color: Colors.green),
                  )
                ),
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
            draft_hikes.add(HikeDraft("title${Random().nextInt(999)}",points));
            setState(() {page=0;});
            // print(points);
            points=[];
          },
        ),
      );
    }
  }
}
