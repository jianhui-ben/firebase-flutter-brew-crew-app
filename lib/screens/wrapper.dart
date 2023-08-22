import 'package:firebase_flutter_brew_crew_app/screens/authenticate/authenticate.dart';
import 'package:firebase_flutter_brew_crew_app/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    //return either Home or Authenticate widget
    // return Home();
    return Authenticate();
  }
}
