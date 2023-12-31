import 'package:firebase_flutter_brew_crew_app/screens/home/brewList.dart';
import 'package:firebase_flutter_brew_crew_app/screens/home/settings_form.dart';
import 'package:firebase_flutter_brew_crew_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/brew.dart';
import '../../services/auth.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // reason why this is inside the build method is because we need access to context
    void _showSettingPanels() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: SettingsForm());
          });
    }

    return StreamProvider<List<Brew?>?>.value(
      value: DatabaseService().brew,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Brew Crew"),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.person, color: Colors.brown[900]), // Your icon
                  SizedBox(height: 1), // Spacer between icon and text
                  Text(
                    'logout',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.brown[900],
                    ),
                  ), // Your text
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                // show settings bottom sheet
                _showSettingPanels();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.settings, color: Colors.brown[900]), // Your icon
                  SizedBox(height: 1), // Spacer between icon and text
                  Text(
                    'setting',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.brown[900],
                    ),
                  ), // Your text
                ],
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/coffee-home-background.jpg"),
              // image: AssetImage("assets/coffee-bean-avatar.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
            child: Column(
            children: [
              BrewList(),
            ],
          )
        ),
      ),
    );
  }
}
