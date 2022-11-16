import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Classes/HikeData.dart';
import 'map.dart';

List<HikeDraft> draft_hikes=[HikeDraft(title: "Title1", points: [])];

class draft_hike_widget extends StatelessWidget{
  draft_hike_widget({Key? key,required this.data}) : super(key: key);
  HikeDraft data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: new BoxDecoration(color: Colors.red),
      color: Colors.greenAccent,
      child: Text(data.title),
    );
  }

}

class Planner extends StatefulWidget {
  const Planner({Key? key}) : super(key: key);

  @override
  _PlannerState createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: Column(
          children: [
            for ( var i in draft_hikes ) Text(i.toString())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {

        },
      ),
    );
  }
}
