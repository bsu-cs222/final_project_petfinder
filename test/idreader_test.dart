import 'dart:io';
import 'package:cs222_final_project_pet_finder/favorites_pet_id_sifter.dart';
import 'package:cs222_final_project_pet_finder/pet.dart';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final listIDs = [69316382, 69316378];
  final parser = PetFinderParser();
  final File petTestFile = File('test/apiResponse.json');
  final fileContents = petTestFile.readAsStringSync();
  final results = parser.parsePetInfo(fileContents);
  final petSifter = FavPetIDSifter();
  List<dynamic> finalPets = petSifter.findPetObjects(listIDs, results);
  test('The objects returned is the right one', () {
    Pet pet = finalPets[0];
    int testedID = pet.petID;
    expect(testedID, listIDs[0]);
  });
  test('the names listed are Count Coolman and Salem', () {
    String finalPetNames = '';
    for (var pet in finalPets) {
      finalPetNames += '${pet.name}';
    }
    expect(finalPetNames, 'Count CoolmanSalem ');
  });
}
