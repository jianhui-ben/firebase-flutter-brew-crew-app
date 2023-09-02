import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_flutter_brew_crew_app/shared/constants.dart';

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



  @override
  Widget build(BuildContext context) {
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
              value: _curSugars ?? "0",
              onChanged: (String? selectedSugarValue) {
                setState(() {
                  _curSugars = selectedSugarValue!;
                });
              },
              items: sugars.map((String sugar) {
                return DropdownMenuItem<String>(
                  value: sugar,
                  child: Text("$sugar sugars"),
                );
              }).toList(),
              validator: (value) {
                return sugars.contains(value)
                    ? null
                    : "Please enter a sugar";
              },
              decoration: textInputDecoration.copyWith(
                  labelText: 'Sugar level', errorText: "Please select a valid sugar"),
            ),

            const SizedBox(
              height: 20,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.brown[_curStrength!],
                    inactiveTrackColor: Colors.grey,
                    trackHeight: 4.0,
                    thumbColor: Colors.brown[_curStrength!],
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                  ),
                  child: Slider(
                    value: (_curStrength ?? 100).toDouble() ,
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
                  'Selected Number: ${_curStrength?.toStringAsFixed(0)}',
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
              },
              child: Text(
                "Update",
                style: TextStyle(fontSize: 20, color: Colors.brown[400]),
              ),
            )
          ],
        ));
  }
}
