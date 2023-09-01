import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  String uid;
  DatabaseService({ required this.uid });

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

}