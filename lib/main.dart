import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hiking_app/Classes/HikeData.dart';
import 'package:hiking_app/Classes/Utils.dart';
import 'package:hiking_app/Pages/LoginPage/wrapper.dart';
import 'package:hiking_app/Services/auth.dart';
import 'package:provider/provider.dart';

import 'map.dart';
import 'planner_page.dart';
import 'location.dart';
import 'Pages/ProfilePage/profile_page.dart';
import 'Classes/UserData.dart';
import 'hiking.dart';

void main() async {
  //Initializes firebase core
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await init_cache();
  runApp(myApp());
}

//Nav key for updating navigation
final navigatorKey = GlobalKey<NavigatorState>();

//this is where everything is tied together
class myApp extends StatelessWidget { //as of now this is complete I think
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    init_location();
    return StreamProvider<UserData?>.value(
      //The Stream provider listens and updates the user data so that all widgets can access the UserData
      value: AuthService().user,
      initialData: null,
      catchError: (_, __) => null,

      child: MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        title: "Hiking App",
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 4, 75, 22),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent
        ),
        debugShowCheckedModeBanner: false, //idk why this is here but the geeksforgeeks page had it
        home: const Wrapper(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int pageIndex = 0;

  final pages = [
    const Map(),
    const Planner(),
    const ProfilePageWidget(),
    const Hike(),
  ];
  void CHANGE_MAIN_VIEW(int page){
    setState(() {
      pageIndex=page;
    });
  }

  @override
  Widget build(BuildContext context) {
    CHANGE_MAIN_VIEW_CALLBACK=CHANGE_MAIN_VIEW;
    return Scaffold( //this stuff could be broken into a seperate class but it's confusing
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: pageIndex==3?0:60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {pageIndex = 0;});
              },
              icon: Icon(
                Icons.landscape,
                color: pageIndex == 0?Colors.brown:Colors.white,
                size: 40,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {pageIndex = 1;});
              },
              icon: Icon(
                Icons.map,
                color: pageIndex == 1?Colors.brown:Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {pageIndex = 2;});
              },
              icon: Icon(
                Icons.account_circle,
                color: pageIndex == 2?Colors.brown:Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  int page=0;
  List<Marker> hikes=[];
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    hikes=[];
    for( var i in globalUserHikesList){
      hikes.add(Marker(
        point: i.points.first,
        width: 50,
        height: 50,
        builder: (context) => ElevatedButton(onPressed:(){}, child:const Icon(Icons.hiking)),
      ));
      //
    }
    return Stack(
      children: [
        Container(
          color: Color.fromARGB(103, 0, 250, 67), //this controls the backround color
          child: Center( //it was blue lining if I didn't have this. Idk why but ok
            child: FullMap(showUserLocation: true, defaultZoom: 14, markers: hikes),
          )
        )
      ],
    );
  }
}

