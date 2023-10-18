import 'dart:io';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter_test/flutter_test.dart';
final parser = PetFinderParser();
final File petTestFile = File('test/apiResponse.json');
final fileContents = petTestFile.readAsStringSync();

void main() async{
  //Write a class that will return the zipcode of the pet found
  test (' When I enter 47306, I find data for the pets nearby', () async{
    final result = await parser.makeRequestToAPI();
    expect(result, '47306');
  });

  test ('Return the names of five pets from query response', () {
    final results = parser.findFive(fileContents);
    var petNames = '';
    for (var result in results){
      petNames += '${result.name}, ';
    }
    expect(petNames, 'Bones, Charm, Count Coolman, Tara, Salem, ');
  });

  test ('Return the names of one pet and their corresponding species and breed', () {
    final results = parser.findFive(fileContents);
    var petNames = '';
    for (var result in results){
      petNames += '${result.name}, ';
    }
    expect(petNames, 'Name: Bone');
  });
}
