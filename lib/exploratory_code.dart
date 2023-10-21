import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'dart:io';

void main() async{
    final parser = PetFinderParser();
    // final result = await parser.makeRequestToAPI();
    // print(result);

    final File petTestFile = File('test/apiResponse.json');
    final fileContents = petTestFile.readAsStringSync();
    final results = parser.parseFivePets(fileContents);

    for (var result in results){
        print('${result.name} is a ${result.breed} ${result.species}.');
    }
}
