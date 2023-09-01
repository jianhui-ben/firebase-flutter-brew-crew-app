import 'package:firebase_flutter_brew_crew_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_brew_crew_app/models/user.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFireBaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //create custom user object based on the firebase user
  BrewUser? _userFromFireBaseUser(User? user) {
    return user != null ? BrewUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<BrewUser?> get userCredential {
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user);
    } catch(e) {
      return e.toString();
    }
  }


  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      String uid = user!.uid;

      await DatabaseService(uid: uid).updateUserData("0", "new crew member", 100);
      return _userFromFireBaseUser(user);
    } catch(e) {
      return e.toString();
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}