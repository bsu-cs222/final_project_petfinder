import 'dart:convert';
import 'package:cs222_final_project_pet_finder/pet.dart';
import 'package:cs222_final_project_pet_finder/data_evaluator.dart';

class PetFinderParser {
  final evaluator = DataEvaluator();
  List parsePetInfo(queryResponse) {
    final decodedAPIResponse = json.decode(queryResponse);
    final listOfReturnedAnimals = decodedAPIResponse['animals'];
    List<Pet> pets = List<Pet>.generate(listOfReturnedAnimals.length, (index) {
      return Pet(
          name: listOfReturnedAnimals[index]['name'],
          species: evaluator.evaluateSpecies(listOfReturnedAnimals[index]['type']),
          breed: listOfReturnedAnimals[index]['breeds']['primary'],
          urlString: listOfReturnedAnimals[index]['url'],
          photos: listOfReturnedAnimals[index]['photos'],
          zipcode: listOfReturnedAnimals[index]['contact']['address']
              ['postcode'],
          gender: evaluator.evaluateGender(listOfReturnedAnimals[index]['gender']),
          age: evaluator.evaluateAge(listOfReturnedAnimals[index]['age']),
      petID: listOfReturnedAnimals[index]['id']);
    });
    return pets;
  }

  int parseTotalResults(queryResponse) {
    final decodedAPIResponse = json.decode(queryResponse);
    final totalOfAnimal = decodedAPIResponse['pagination']['total_count'];
    return totalOfAnimal;
  }
}
