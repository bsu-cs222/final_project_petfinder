import 'dart:convert';
import 'package:cs222_final_project_pet_finder/pet.dart';


class PetFinderParser {
  List parsePetInfo(queryResponse) {
    final decodedAPIResponse = json.decode(queryResponse);
    print (decodedAPIResponse);
    final listOfReturnedAnimals = decodedAPIResponse['animals'];
    List<Pet> pets = List<Pet>.generate(listOfReturnedAnimals.length, (index) {
      return Pet(
        name: listOfReturnedAnimals[index]['name'],
        species: evaluateSpecies(listOfReturnedAnimals[index]['species']),
        breed: listOfReturnedAnimals[index]['breeds']['primary'],
        urlString: listOfReturnedAnimals[index]['url'],
        photos: listOfReturnedAnimals[index]['photos'],
        zipcode: listOfReturnedAnimals[index]['contact']['address']['postcode'],
        gender: evaulateGender(listOfReturnedAnimals[index]['gender']),
        age: evaluateAge(listOfReturnedAnimals[index]['age']),
      );
    });

    return pets;
  }

  GenderType evaulateGender(petListedGender) {
    switch (petListedGender) {
      case 'Male':
        return GenderType.male;
      default:
        return GenderType.female;

  }}
  AgeType evaluateAge(petListedAge){
    switch(petListedAge){
      case 'Baby':
        return AgeType.baby;
      case 'Young':
        return AgeType.young;
      case 'Adult':
        return AgeType.adult;
      default:
        return AgeType.senior;
    }
  }
  SpeciesType evaluateSpecies(petListedSpecies){
    switch(petListedSpecies){
      case'Dog':
        return SpeciesType.dog;
      case'Cat':
        return SpeciesType.cat;
      case'Barnyard':
        return SpeciesType.barnyard;
      case 'Bird':
        return SpeciesType.bird;
      case 'Rabbit':
        return SpeciesType.rabbit;
      case 'Horse':
        return SpeciesType.horse;
      default:
        return SpeciesType.other;
    }
  }
}
