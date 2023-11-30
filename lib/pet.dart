enum GenderType { male, female, any }
enum AgeType {baby, young, adult, senior, any}

class Pet {
  final String name;
  final String species;
  final String breed;
  final String urlString;
  final List photos;
  final GenderType gender;
  final String zipcode;
  final AgeType age;

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