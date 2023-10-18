import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'dart:io';

void main() {
    final parser = PetFinderParser();
    // final result = await parser.makeRequestToAPI();
    // print(result);

    final File petTestFile = File('test/apiResponse.json');
    final fileContents = petTestFile.readAsStringSync();
    final results = parser.findFive(fileContents);

    for (var result in results){
        print('Pet Name: ${result.name}, Species: ${result.species}, Breed: ${result.breed}');
    }
}
