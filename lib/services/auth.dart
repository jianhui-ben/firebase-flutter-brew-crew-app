import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_brew_crew_app/models/user.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return _userFromFireBaseUser(userCredential);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //create custom user object based on the firebase user
  BrewUser? _userFromFireBaseUser(UserCredential userCredential) {
    return userCredential != null ? BrewUser(uid: userCredential.user!.uid) : null;
  }

  // sign in with email & password


  // register with email & password

  // sign out




}