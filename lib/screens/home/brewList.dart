import 'package:firebase_flutter_brew_crew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/brew.dart';
import 'brewTile.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});


  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {

  @override
  Widget build(BuildContext context) {

    //check the brew stream
    final brewStream = Provider.of<List<Brew?>?>(context);

    if (brewStream == null) {
      // Handle the case where brewStream is null, e.g., show a loading indicator or an error message.
      return const Loading(); // You can replace this with an appropriate widget.
    }

    return Expanded(
      child: ListView.builder(
          itemCount: brewStream.length,
          itemBuilder: (context, index) {
            return BrewTile(brew : brewStream[index]);
      }),
    );
  }
}
