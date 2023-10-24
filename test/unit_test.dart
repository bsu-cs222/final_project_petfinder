import 'dart:io';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter_test/flutter_test.dart';
final parser = PetFinderParser();
final File petTestFile = File('test/apiResponse.json');
final fileContents = petTestFile.readAsStringSync();

void main(){
  test ('Return the names of five pets from query response', () {
    final results = parser.parseFivePets(fileContents);
    var petNames = '';
    for (var result in results){
      petNames += '${result.name}, ';
    }
    expect(petNames, 'Bones, Charm, Count Coolman, Tara, Salem, ');
  });

  test ('Return the names of one pet and their corresponding species and breed', () {
    final results = parser.parseFivePets(fileContents);
    var petInfo = '';
    for (var result in results){
      petInfo += '${result.name} is a ${result.breed} ${result.species}.';
    }
    expect(petInfo, 'Bones is a Domestic Short Hair Cat.'
    'Charm is a Pit Bull Terrier Dog.'
    'Count Coolman is a Domestic Short Hair Cat.'
    'Tara is a Jack Russell Terrier Dog.'
        'Salem is a Pit Bull Terrier Dog.' );
  });
  test ('Return the url for pet photo', () {
    final results = parser.parseFivePets(fileContents);
    var petPhotoURL = '';
    for (var result in results){
      petPhotoURL += '${result.photos}';
    }
    expect(petPhotoURL, '[{small: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316379/1/?bust=1697452576&width=100, medium: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316379/1/?bust=1697452576&width=300, large: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316379/1/?bust=1697452576&width=600, full: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316379/1/?bust=1697452576}][{small: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316381/1/?bust=1697452576&width=100, medium: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316381/1/?bust=1697452576&width=300, large: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316381/1/?bust=1697452576&width=600, full: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316381/1/?bust=1697452576}][{small: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316382/1/?bust=1697452583&width=100, medium: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316382/1/?bust=1697452583&width=300, large: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316382/1/?bust=1697452583&width=600, full: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316382/1/?bust=1697452583}][][{small: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316378/1/?bust=1697452662&width=100, medium: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316378/1/?bust=1697452662&width=300, large: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316378/1/?bust=1697452662&width=600, full: https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/69316378/1/?bust=1697452662}]');
  });
}
