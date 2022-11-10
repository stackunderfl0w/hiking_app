import 'HikeData.dart';

class UserData {
  String username = 'UserName';
  String password = 'apples';
  List <HikeData>? hikesList;

  //Constructor
  UserData({required this.username});

  //Methods
  addHike(HikeData hike) {
    hikesList?.add(hike);
  }

  removeHike(HikeData hike) {
    hikesList?.remove(hike);
  }

}