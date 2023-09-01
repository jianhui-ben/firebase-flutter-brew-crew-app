import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/brew.dart';

class DatabaseService {

  String? uid;
  DatabaseService({ this.uid });

  // collection reference
  final brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {

    // Create a new user with a first and last name
     var newUserBrewData  = <String, dynamic>{
      "sugars": sugars,
      "name": name,
      "strength": strength
    };
    return await brewCollection
        .doc(uid)
        .set(newUserBrewData)
        .onError((e, _) => print("Error writing document: $e"));
  }

  // create another stream of brew to update the brewData for a user
  Stream<List<Brew?>?>? get brew {
    return convertQuerySnapshotToBrew();
    // return brewCollection.snapshots();
  }

  Stream<List<Brew?>?>? convertQuerySnapshotToBrew() {
    return brewCollection.snapshots().map((querySnapshot) {
      // Use the querySnapshot to create a list of YourCustomObject
      List<Brew> brewStream = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        // Convert data from the document to Brew
        brewStream.add(Brew(
            name: document["name"],
            strength: document["strength"],
            sugars: document["sugars"]));
      }
      return brewStream;
    });
  }
}