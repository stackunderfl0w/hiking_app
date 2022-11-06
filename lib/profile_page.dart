import 'dart:ui';

import 'package:flutter/material.dart';

//Main Profile Page Widget
class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key? key}) : super(key: key);

  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  //User Variables
  final String _userName = 'Username';

  /* Hike Object List
  int _userHikesIdx = 0;

  final _hikesList = [

  ];
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF95FAB0),

        //**Main Column
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            //**User Column Stuff
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: Text(
                        _userName,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                         fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xFF1B5E20),
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 15.0,
                              color: Color.fromARGB(100, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Icon(
                      Icons.account_circle,
                      color: Theme.of(context).primaryColor,
                      size: 100,
                      shadows: const <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 15.0,
                          color: Color.fromARGB(100, 0, 0, 0),
                        ),
                      ],
                      //size: Size.fromHeight(30.0),
                    ),
                  ),

                  //**Logout Button
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.exit_to_app_rounded,
                          size: 24.0,
                          color: Color(0xFF1B5E20),
                        ),
                        label: const Text(
                            'Logout',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF1B5E20),
                            ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 192, 251, 208),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //**Hike List Column
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                color: const Color.fromARGB(255, 192, 251, 208),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    //**USER HIKES GO HERE
                    Text(
                      'Hike Object Here',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                    Text(
                      'Hike Object Here',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                    Text(
                      'Hike Object Here',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFF1B5E20),
                      ),
                    ),

                  ],
                )
              ),
            )
          ],


        )
    );
  }
}


//Profile Page Hike Object Widget
class PPHikeWidget extends StatefulWidget {
  const PPHikeWidget({Key? key}) : super(key: key);

  @override
  _PPHikeWidgetState createState() => _PPHikeWidgetState();
}
class _PPHikeWidgetState extends State<PPHikeWidget> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}

