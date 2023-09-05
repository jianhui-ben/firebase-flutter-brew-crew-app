// mainly used for authentification
import 'brew.dart';

class BrewUser {
  final String uid;

  BrewUser({required this.uid});

  @override
  String toString() {
    return "uid: $uid";
  }
}

//used to store the brew data
class BrewUserData {
  final String uid;
  final Brew brew;

  BrewUserData({required this.uid, required this.brew});

  @override
  String toString() {
    return "uid: $uid, brew data: $brew";
  }

}