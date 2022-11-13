import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hiking_app/LoginPage/Login.dart';
import 'package:hiking_app/main.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Grabs the user from the provider
    final user = Provider.of<User?>(context);

    if(user == null) {
      //Return the login page widget if the user isn't signed in
      return LoginPage();
    }
    else {
      //Return the home page if the user is signed in
      return HomePage();
    }

  }
}

