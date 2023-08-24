import 'package:firebase_flutter_brew_crew_app/screens/wrapper.dart';
import 'package:firebase_flutter_brew_crew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'models/user.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<BrewUser?>.value(
      value: AuthService().userCredential,
      initialData: null,
      child: MaterialApp(
        home: Wrapper()
      ),
    );
  }
}
