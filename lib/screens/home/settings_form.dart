import 'package:firebase_flutter_brew_crew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter_brew_crew_app/shared/constants.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../services/database.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];
  String? _curName;
  String? _curSugars;
  int? _curStrength;


  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {

    final userCredential = Provider.of<BrewUser?>(context);
    return StreamBuilder<BrewUserData?>(
      stream: DatabaseService(uid: userCredential!.uid).brewUserData,
      builder: (context, snapshot) {
        //here the snapshot is flutter-builtin for streamBuilder, which represent the stream current snapshot
        // in our case, it will be current BrewUserData

        if (snapshot.hasData) {
          BrewUserData? curBrewUserData = snapshot.data;
          String snapShotName = curBrewUserData!.brew.name;
          String snapShotSugars = curBrewUserData.brew.sugars;
          int snapShotStrength = curBrewUserData.brew.strength;

          return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Update your brew setting",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.brown[400],
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: snapShotName,
                    onChanged: (value) {
                      setState(() {
                        _curName = value;
                      });
                    },
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? "Please enter a name"
                          : null;
                    },
                    decoration: textInputDecoration.copyWith(
                        labelText: 'Name',
                        errorText: _formKey.currentState == null || _formKey.currentState!.validate() ? null : "Please enter a valid name"
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //drop down to select sugars

                  DropdownButtonFormField<String>(
                    value: _curSugars ?? snapShotSugars,
                    onChanged: (value) {
                      setState(() {
                        _curSugars = value!;
                      });
                    },
                    items: sugars.map((String sugar) {
                      return DropdownMenuItem<String>(
                        value: sugar,
                        child: Text("$sugar sugars"),
                      );
                    }).toList(),
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Sugar level',
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.brown[_curStrength ?? snapShotStrength],
                          inactiveTrackColor: Colors.grey,
                          trackHeight: 4.0,
                          thumbColor: Colors.brown[_curStrength ?? snapShotStrength],
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                        ),
                        child: Slider(
                          value: (_curStrength  ?? snapShotStrength).toDouble() ,
                          activeColor: Colors.brown[_curStrength ?? snapShotStrength],
                          inactiveColor: Colors.brown[_curStrength  ?? snapShotStrength],
                          min: 100.0,
                          max: 900.0,
                          divisions: 8,
                          onChanged: (value) {
                            setState(() {
                              _curStrength = value.round(); // Update selected number
                            });
                          },
                        ),
                      ),
                      Text(
                        'Selected Number: ${(_curStrength ?? snapShotStrength).toStringAsFixed(0)}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),

                  //slider to select strength

                  const SizedBox(
                    height: 20,
                  ),

                  OutlinedButton(
                    onPressed: () {
                      // Respond to button press


                      print("name: $_curName, sugar: $_curSugars, strength: $_curStrength");

                      // await DatabaseService(uid: ).removeUserData();
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(fontSize: 20, color: Colors.brown[400]),
                    ),
                  )
                ],
              ));
        } else {
          return Loading();
        }
      }
    );
  }
}
