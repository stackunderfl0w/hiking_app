import 'package:latlong2/latlong.dart';

class HikeData {
  String title = 'Hike Title';
  String owner = 'Admin';
  bool owned=true;

  double length=0;
  //1-5
  double difficulty = 0;
  bool comments = true;
  bool private = true;

  //List<HikePoint> points;
  List<LatLng> points;
  late List<double> times;



  HikeData({required this.title, required this.points, required this.difficulty, required this.private, required this.comments, required this.owned}){
    for(var i=1; i<points.length; i++) {
      length+=Distance().distance(points[i], points[i-1])/1000;
    }
  }
  HikeData.draft({required this.title, required this.points }){
    difficulty=0;
    private=true;
    times=[0];
  }
}