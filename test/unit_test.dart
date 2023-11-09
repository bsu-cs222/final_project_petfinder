import 'dart:io';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter_test/flutter_test.dart';

final parser = PetFinderParser();
final File petTestFile = File('test/apiResponse.json');
final fileContents = petTestFile.readAsStringSync();

void main() {
  final results = parser.parseFivePets(fileContents);
  test('Expect that the names of the pets are Bones, Charm, Count Coolman, Tara, and Salem', () {
    var petNames = '';
    int counter=0;
    var expectedPetNames=['Bones', 'Charm', 'Count Coolman', 'Tara', 'Salem'];
    for (var result in results) {
      petNames = result.name;
      expect (petNames,expectedPetNames[counter]);
      counter++;
    }
  });

  test('Return the names of five pets and their corresponding species and breed',
      () {
    var petInfo = '';
    for (var result in results) {
      petInfo += '${result.name} ${result.breed} ${result.species}.';
    }
    expect(
        petInfo,
        'Bones Domestic Short Hair Cat.'
        'Charm Pit Bull Terrier Dog.'
        'Count Coolman Domestic Short Hair Cat.'
        'Tara Jack Russell Terrier Dog.'
        'Salem Pit Bull Terrier Dog.');
  });
  test('Returns the url for 5 pet photo, small medium and large.', () {
    var petPhotoURL = '';
    for (var result in results) {
      petPhotoURL += '${result.photos}';
    }
    expect(
        petPhotoURL,
        '[{small: '
        'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316379/1/?bust=1697452576&width=100, '
        'medium: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316379/1/?bust=1697452576&width=300,'
        ' large: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316379/1/?bust=1697452576&width=600, '
        'full: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316379/1/?bust=1697452576}]['
        '{small: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316381/1/?bust=1697452576&width=100,'
        ' medium: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316381/1/?bust=1697452576&width=300,'
        ' large: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316381/1/?bust=1697452576&width=600,'
        ' full: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316381/1/?bust=1697452576}]['
        '{small: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316382/1/?bust=1697452583&width=100, '
        'medium: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316382/1/?bust=1697452583&width=300, '
        'large: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316382/1/?bust=1697452583&width=600, '
        'full: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316382/1/?bust=1697452583}]'
        '[]'
        '[{small: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316378/1/?bust=1697452662&width=100, '
        'medium: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316378/1/?bust=1697452662&width=300, '
        'large: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316378/1/?bust=1697452662&width=600, '
        'full: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316378/1/?bust=1697452662}]');
  });
  test('The zipcodes of the first pet is 47401',(){
    var petZipCode='';
    petZipCode=results[0].zipcode;
    expect(petZipCode,'47401');
  });
}
