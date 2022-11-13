import 'package:firebase_auth/firebase_auth.dart';
import 'package:hiking_app/Classes/UserData.dart';

class AuthService {

  //Private firebase authentication object instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //**METHODS:

  //Create userData based off of FirebaseUser
  UserData? _userFromFirebaseUser(User user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  //Auth change user stream (procs when the user signs in or out).
  Stream<UserData?> get user {
    print('Stream called'!);
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user!));
  }

  //Sign in anonymously
  Future signInAnon() async {
    try {
      //Try to make an authentication request
      UserCredential result =  await _auth.signInAnonymously();
      User? user = result.user;
      //print(result.user?.uid);
      return _userFromFirebaseUser(user!);
    }catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password

  //register with email and password

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}