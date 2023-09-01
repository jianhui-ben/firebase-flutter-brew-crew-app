class Brew {

  final String name;
  final int strength;
  final String sugars;

  Brew({required this.name, required this.strength, required this.sugars});

  @override
  String toString() {
    return "name: $name, strength: $strength, sugars: $sugars";
  }

  Brew? updateBrewData() {

  }

}