import 'package:flutter/material.dart';
import '../../models/brew.dart';


class BrewTile extends StatelessWidget {

  final Brew? brew;
  const BrewTile({super.key, required this.brew});

  @override
  Widget build(BuildContext context) {
    // return Card(child: Text(brew!.name));
    return buildCard();
  }

  Padding buildCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
          elevation: 4.0,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.brown[brew!.strength],
                  backgroundImage: AssetImage('assets/coffee_icon.png'),
                ),
                title: Text(brew!.name),
                subtitle: Text("Takes ${brew!.sugars} and strength is ${brew!.strength}"),
                trailing: Icon(Icons.favorite_outline),
              ),
            ],
          )),
    );
  }

}

