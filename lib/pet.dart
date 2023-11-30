enum GenderType { male, female, any }

class Pet {
  final String name;
  final String species;
  final String breed;
  final String urlString;
  final List photos;
  final GenderType gender;
  final String zipcode;
  final String age;

  const Pet(
      {required this.name,
        required this.species,
        required this.breed,
        required this.urlString,
        required this.photos,
        required this.zipcode,
        required this.age,
        required this.gender});
}