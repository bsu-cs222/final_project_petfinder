import 'dart:io';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test(' When I enter 47306, I find data for the pets nearby', () async {
    final parser = PetFinderParser();
    final result = await parser.makeRequestToAPI();
    expect(result, '47306');
  });
  // This is going to decode the JSON into variables
  test(
      'When I enter Indiana, I receive the JSON code for the top five pets in the area',
      () async {
    final parser = PetFinderParser();
    final File petTestFile = File('test/apiResponse.json');
    final fileContents = petTestFile.readAsString();
    final result = await parser.findFive(fileContents);
    expect(result, '47306');
  });
  test('I can display an image url', () {
    final parser = PetFinderParser();
    final result = parser.image();
    expect(result,
        'https://photos.petfinder.com/photos/pets/42706540/1/?bust=1546042081&width=100');
  });
}
