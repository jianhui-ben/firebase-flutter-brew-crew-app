import 'package:cloud_firestore/cloud_firestore.dart';
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
    final brewStream = Provider.of<List<Brew?>?>(context)!;
    // for (Brew? brewData in brewStream) {
    //   print(brewData);
    // }

    return Expanded(
      child: ListView.builder(
          itemCount: brewStream.length,
          itemBuilder: (context, index) {
            return BrewTile(brew : brewStream[index]);
      }),
    );
  }
}
