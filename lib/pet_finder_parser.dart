import 'dart:convert';

import 'package:cs222_final_project_pet_finder/pet.dart';
enum GenderType { male, female, any }




class PetFinderParser {
  List parsePetInfo(queryResponse) {
    final decodedAPIResponse = json.decode(queryResponse);
    final listOfReturnedAnimals = decodedAPIResponse['animals'];
    List<Pet> pets = List<Pet>.generate(listOfReturnedAnimals.length, (index) {
      return Pet(
        name: listOfReturnedAnimals[index]['name'],
        species: listOfReturnedAnimals[index]['species'],
        breed: listOfReturnedAnimals[index]['breeds']['primary'],
        urlString: listOfReturnedAnimals[index]['url'],
        photos: listOfReturnedAnimals[index]['photos'],
        zipcode: listOfReturnedAnimals[index]['contact']['address']['postcode'],
        gender: evaulateGender(listOfReturnedAnimals[index]['gender']),
        age: listOfReturnedAnimals[index]['age'],
      );
    });

    return pets;
  }

  GenderType evaulateGender(petListedGender) {
    switch (petListedGender) {
      case 'Male':
        return GenderType.male;
      case 'Female':
        return GenderType.female;
      default:
        return GenderType.any;
    }
  }
}
