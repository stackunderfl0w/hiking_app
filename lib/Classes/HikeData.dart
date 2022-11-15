
class HikePoint{
  //Types subject to change
  double latitude;
  double longitude;
  double time;
  HikePoint({required this.latitude, required this.longitude, this.time=0});
}
class HikeData {
  String title = 'Hike Title';
  String owner = 'Admin';
  bool owned=true;

  //Miles
  double distance=0;
  //1-10
  double difficulty = 0;
  bool comments = true;
  bool private = true;
  List<HikePoint> points;


  HikeData({required this.title, required this.points, required this.difficulty, required this.private });
}