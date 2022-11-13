import 'HikeData.dart';

class UserData {
  final String uid;
  String password = 'apples';
  List <HikeData>? hikesList;

  //Constructor
  UserData({ required this.uid});

  //Methods
  addHike(HikeData hike) {
    hikesList?.add(hike);
  }

  removeHike(HikeData hike) {
    hikesList?.remove(hike);
  }

}
