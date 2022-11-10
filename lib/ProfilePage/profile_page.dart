import 'package:flutter/material.dart';
import 'Custom_Widgets/PPHikeWidget.dart';
import '../Classes/UserData.dart';

//**Main Profile Page Widget
class ProfilePageWidget extends StatefulWidget {
  //const ProfilePageWidget({Key? key}) : super(key: key);
  final UserData user;

  //**Constructor
  const ProfilePageWidget({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState(user);
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  //User Variables
  late UserData user = UserData(username: 'Username');

  //**Constructor
  _ProfilePageWidgetState(this.user);


  //**Methods
  Widget getHikeWidgets(UserData user) {
    //If user hikes were defined for this user
    if(user.hikesList != null) {
        return Expanded(
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
                      children:
                      //**US?.R HIKES GO HERE
                      user.hikesList!.map((hike) => PPHikeWidget(hikedata: hike)).toList(),//;
                    //if(user.hikesList.isEmpty == false )
                    // user.hikesList.map((hike) => PPHikeWidget(hikedata: hike)).toList(),

                  ),
                ),
              )
          ),
        );//user.hikesList.map((hike) => PPHikeWidget(hikedata: hike)).toList();
    }
    //No User hikes defined
    else {
      return Expanded(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:const [
                    Text(
                      'No User Hikes Found',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromARGB(255,55, 89, 65),
                      ),
                    ),
                    Text(
                      'Go to the exploration or planner page to start a hike!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color.fromARGB(255,55, 89, 65),
                      ),
                    ),
                  ]
                ),
              ),
            )
        ),
      );
    }
  }

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
                        user.username,
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
                          print('Logging Out ${user.username}');
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
             getHikeWidgets(user),

          ],
        )
    );
  }
}

