import 'dart:io';
import 'package:cs222_final_project_pet_finder/enum_decoder.dart';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final parser = PetFinderParser();
  final File petTestFile = File('test/apiResponse.json');
  final fileContents = petTestFile.readAsStringSync();
  final results = parser.parsePetInfo(fileContents);
  final enumDecoder = EnumDecoder();
  test(
      'When asked to decode the Gender enum from GenderType.male it will return String Male',
      () {
    var petResult = results[0].gender;
    var result = enumDecoder.decodeGenderEnum(petResult);
    expect(result, 'Male');
  });
  test('When asked to decode the species enum from SpeciesType.cat it will return String Cat',(){
    var petResult=results[0].species;
    var result=enumDecoder.decodeSpeciesEnum(petResult);
    expect(result,'Cat');
  });
}
