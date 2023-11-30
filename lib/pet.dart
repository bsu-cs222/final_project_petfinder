enum GenderType { male, female}
enum AgeType {baby, young, adult, senior}
enum SpeciesType{cat, dog}
class Pet {
  final String name;
  final SpeciesType species;
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