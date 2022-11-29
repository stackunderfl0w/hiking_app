import 'package:latlong2/latlong.dart';
/*class HikePoint{
  //Types subject to change
  LatLng point;
  double time;
  HikePoint({required this.point, this.time=0});
}*/
/*class HikeDraft{
  String title = 'Hike Title';
  String owner = 'Admin';
  late List<LatLng> points;
  // this is not necessary and just left as a reference for me
  HikeDraft( this.title,List<LatLng> p){
    points=[];
    for ( var i in p ) {
      points.add( i);
    }
  }
}*/
class HikeData {
  String title = 'Hike Title';
  String owner = 'Admin';
  bool owned=true;

  //Miles
  double distance=0;
  //1-5
  double difficulty = 0;
  bool comments = true;
  bool private = true;

  //List<HikePoint> points;
  List<LatLng> points;
  late List<double> times;



  HikeData({required this.title, required this.points, required this.difficulty, required this.private, required this.distance, required this.comments, required this.owned});
  HikeData.draft({required this.title, required this.points }){
    difficulty=0;
    private=true;
    times=[0];
  }
}