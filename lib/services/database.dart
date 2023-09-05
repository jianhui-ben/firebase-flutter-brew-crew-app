import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/brew.dart';
import '../models/user.dart';

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

  Future updateUserBrew(Brew brew) async {
    updateUserData(brew.sugars, brew.name, brew.strength);
  }

  // remove user data
  Future removeUserData() async {
    await brewCollection.doc(uid).delete();
  }

  // create a stream of BrewUserData to update the brewData for a user
  Stream<BrewUserData?>? get brewUserData {
    return convertQuerySnapshotToBrewUserData();
  }

  // create another stream of brew to update the brew list
  Stream<List<Brew?>?>? get brew {
    return convertQuerySnapshotToBrew();
    // return brewCollection.snapshots();
  }

  Stream<List<Brew?>?>? convertQuerySnapshotToBrew() {
    return brewCollection.snapshots().map((querySnapshot) {
      // Use the querySnapshot to create a list of brew
      List<Brew> brewStream = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        // Convert data from the document to Brew
        brewStream.add(Brew(
            name: document["name"] ?? "",
            strength: document["strength"] ?? 0,
            sugars: document["sugars"] ?? "0"));
      }
      return brewStream;
    });
  }

  Stream<BrewUserData?>? convertQuerySnapshotToBrewUserData() {
    return brewCollection.doc(uid).snapshots().map((docSnapshot) {
      return BrewUserData(
          uid: uid!,
          brew: Brew(
              name: docSnapshot["name"],
              strength: docSnapshot["strength"],
              sugars: docSnapshot["sugars"]));
    });
  }
}