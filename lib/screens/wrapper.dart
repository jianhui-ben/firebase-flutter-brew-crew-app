import 'package:firebase_flutter_brew_crew_app/screens/authenticate/authenticate.dart';
import 'package:firebase_flutter_brew_crew_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    //check the brewUser stream
    final userCredential = Provider.of<BrewUser?>(context);
    // print(userCredential);

    //return either Home or Authenticate widget
    if (userCredential == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
