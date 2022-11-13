import 'package:flutter/material.dart';
import 'package:hiking_app/main.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Return home or login page based widget
    return HomePage();
  }
}

