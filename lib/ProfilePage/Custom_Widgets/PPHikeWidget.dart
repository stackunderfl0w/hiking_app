import 'package:flutter/material.dart';
import '../../Classes/hikeData.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//**Profile Page Hike Object Widget
class PPHikeWidget extends StatelessWidget {
  //Hike data object
  final hikeData hikedata;

  //**Constructor
  const PPHikeWidget({ required this.hikedata });


  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 200,
        minHeight: 120,
        //maxWidth: 1000,
        maxHeight: 120,
      ),

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

        child: Row(

          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 20, 15),
              child: IconButton(
                //Brings you to the planner focusing on the hike that was selected.
                onPressed: () {
                  print('Taking to panner page with hike title: ${hikedata.title}');
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
                        hikedata.title,
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
                      initialRating: hikedata.difficulty,
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
                      '${hikedata.distance} mi',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: const TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color.fromARGB(255,55, 89, 65),
                      ),
                    ),
                  ),

                  if(hikedata.comments == true)
                    const Align(
                      alignment: Alignment(0.8, 0.6),
                      child: Icon(
                        Icons.library_books,
                        size: 35,
                        color: Color.fromARGB(255,55, 89, 65),
                      ),
                    ),

                  if(hikedata.owned == true)
                    const Align(
                      alignment: Alignment(0.65, -0.76),
                      child: Icon(
                        Icons.check_box_outlined,
                        size: 35,
                        color: Color.fromARGB(255, 55, 89, 65),
                      ),
                    ),

                  //**Check if this hike is private or public and change the icon based on it.
                  if(hikedata.private == true)
                    const Align(
                    alignment: Alignment(0.95, -0.8),
                    child: Icon(
                      Icons.lock_outline,
                      size: 35,
                      color: Color.fromARGB(255,55, 89, 65),
                    ),
                  ),
                  if(hikedata.private == false)
                    const Align(
                      alignment: Alignment(0.95, -0.8),
                      child: Icon(
                        Icons.lock_open_outlined,
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
    );
  }

}