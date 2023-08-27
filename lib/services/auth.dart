import 'package:flutter/material.dart';
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


  // register with email & password

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