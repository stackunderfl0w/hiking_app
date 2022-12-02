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



  HikeData({required this.title, required this.points, required this.difficulty, required this.private, required this.comments, required this.owned, required this.times}){
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

List<HikeData> globalUserHikesList = [
  HikeData(title: 'Main Chip Ross Loop', points: [LatLng(44.54534, -123.27086)], difficulty: 4.0, private: true, comments: true, owned: true,times: []),
  HikeData(title: 'Bald Hill to Cardwell Hill', points: [LatLng(44.55534, -123.27286)], difficulty: 2.5, private: true, comments: false, owned: true,times: []),
  HikeData(title: 'Fitton Green trail', points: [LatLng(44.55334, -123.27086)], difficulty: 1.5, private: false, comments: true, owned: false,times: []),
  HikeData(title: 'C2C Trail', points: [LatLng(44.53534, -123.27086)], difficulty: 4.0, private: false, comments: true, owned: false,times: []),
  HikeData(title: 'McDonald Farm', points: [LatLng(44.55634, -123.27186)], difficulty: 3.5, private: false, comments: true, owned: true,times: []),
  HikeData(title: 'Muddy Road', points: [LatLng(44.55934, -123.27386)], difficulty: 1.0, private: true, comments: false, owned: true,times: []),
];
