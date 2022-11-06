import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

//**Main Profile Page Widget
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
                          letterSpacing: 2.0,
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
                        onPressed: () {
                          print('Logging Out $_userName');
                        },
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
                //**Divider Between Both Columns in Decoration
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color.fromARGB(255,55, 89, 65),
                      width: 2.0,
                    )
                  ),
                  color: Color.fromARGB(255, 192, 251, 208),
                ),

                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        //**USER HIKES GO HERE
                        PPHikeWidget(),
                        PPHikeWidget(),
                        PPHikeWidget(),
                        PPHikeWidget(),
                        PPHikeWidget(),
                        PPHikeWidget(),
                        PPHikeWidget(),
                        PPHikeWidget(),
                        PPHikeWidget(),
                        PPHikeWidget(),
                        PPHikeWidget(),
                        PPHikeWidget(),
                      ],
                    ),
                  ),
                )
              ),
            )
          ],


        )
    );
  }
}


//**Profile Page Hike Object Widget
class PPHikeWidget extends StatefulWidget {
  const PPHikeWidget({Key? key}) : super(key: key);

  @override
  _PPHikeWidgetState createState() => _PPHikeWidgetState();
}

class _PPHikeWidgetState extends State<PPHikeWidget> {
  //Variables for the hike
  String _title = 'Hike Title';
  double _distance = 2.7;
  double _difficulty = 3.5;
  bool _owned = true;
  bool _comments = true;
  bool _private = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 200,
        minHeight: 120,
        //maxWidth: 1000,
        maxHeight: 120,
      ),

      child: Expanded(
        child: Container(
          width: double.infinity,
          //height: double.infinity,
          decoration: BoxDecoration(

            borderRadius: const BorderRadius.all(Radius.circular(3.0)),
            border: Border.all(
              color: const Color.fromARGB(255,55, 89, 65),
              width: 6.0,
            ),
          ),

          child: Expanded(
            child: Row(

              children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 20, 15),
                    child: IconButton(
                        //Brings you to the planner focusing on the hike that was selected.
                        onPressed: () {
                          print('Taking to panner page with hike title: $_title');
                        },
                        icon: const Icon(
                          Icons.location_on_sharp,
                          size: 55,
                          color: Color.fromARGB(255,55, 89, 65),
                        ),
                    ),
                  ),

                  Expanded(
                    child: Stack(
                      children:[

                        Align(
                          alignment: const Alignment(-1.0, -0.3),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 100,
                              minHeight: 60,
                              maxWidth: 190,
                              maxHeight: 60,
                            ),
                            child: Text(
                              _title,
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              style: const TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromARGB(255,55, 89, 65),
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: const Alignment(-1.0, 0.6),
                          child: RatingBar(
                              itemSize: 25,
                              itemPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              minRating: 1,
                              maxRating: 5,
                              initialRating: _difficulty,
                              allowHalfRating: true,
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star_outlined,
                                  size: 5,
                                  color: Color.fromARGB(255, 249, 246, 154),
                                ),
                                half: const Icon(
                                  Icons.star_half_outlined,
                                  size: 5,
                                  color: Color.fromARGB(255, 249, 246, 154),
                                ),
                                empty: const Icon(
                                  Icons.star_outline,
                                  size: 5,
                                  color: Color.fromARGB(255, 249, 246, 154),
                                ),
                              ),
                              ignoreGestures: true,
                              onRatingUpdate: (rating) {
                                  print(rating);
                              },
                          ),
                        ),
                        
                        Align(
                          alignment: const Alignment(0.2, 0.6),
                          child: Text(
                            '$_distance mi',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: const TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color.fromARGB(255,55, 89, 65),
                            ),
                          ),
                        ),
                        
                        const Align(
                          alignment: Alignment(0.8, 0.6),
                          child: Icon(
                            Icons.library_books,
                            size: 35,
                            color: Color.fromARGB(255,55, 89, 65),
                          ),
                        ),

                        const Align(
                          alignment: Alignment(0.65, -0.76),
                          child: Icon(
                            Icons.check_box_outlined,
                            size: 35,
                            color: Color.fromARGB(255,55, 89, 65),
                          ),
                        ),

                        const Align(
                          alignment: Alignment(0.95, -0.8),
                          child: Icon(
                            Icons.lock_outline_rounded,
                            size: 35,
                            color: Color.fromARGB(255,55, 89, 65),
                          ),
                        ),

                      ],

                    ),
                  ),

              ],

            ),
          ),


        ),
      ),
    );
  }
  
}

