import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hiking_app/AuthPage/auth_page.dart';

import 'package:hiking_app/main.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<User?>(
        //The Stream provider listens and updates the user data so that all widgets can access the UserData
          stream: FirebaseAuth.instance.authStateChanges(),
          initialData: null,
          //catchError: (_, __) => null,
          builder: (context, snapshot) {
            /*if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(
                color: Color(0xFF1B5E20),
              ));
            }
            else*/ if(snapshot.hasError) {
              return Center(child: Text('Something went wrong signing in!'));
            }
            else if(snapshot.hasData) {
              return HomePage();
            }
            else {
              return AuthPage();
            }
          }
      ),
    );
  }

