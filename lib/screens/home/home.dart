import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Home extends StatelessWidget {

  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Brew Crew Home screen"),
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
                  'sign out',
                  style: TextStyle(fontSize: 10, color: Colors.brown[900],),
                ), // Your text
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
          child: Text("Sign out"),
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ),
    );
  }
}
