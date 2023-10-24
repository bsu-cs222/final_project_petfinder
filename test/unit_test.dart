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
}
