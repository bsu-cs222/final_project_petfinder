import 'dart:io';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter_test/flutter_test.dart';

final parser = PetFinderParser();
final File petTestFile = File('test/apiResponse.json');
final fileContents = petTestFile.readAsStringSync();

void main(){
  final results = parser.parsePetInfo(fileContents);
  test('The enumerated type is successfully returned as male', (){
    var petGender=results[0].gender;
    expect (petGender,GenderType.male);
  });
}