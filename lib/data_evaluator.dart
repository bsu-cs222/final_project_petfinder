import 'package:cs222_final_project_pet_finder/pet.dart';

class DataEvaluator {
  bool evaluateZipcodeInput(String zipcodeBarInput) {
    if (zipcodeBarInput != '') {
      return true;
    } else {
      return false;
    }
  }

  String evaluateGenderInput(String genderBarInput) {
    if (genderBarInput == 'Male' || genderBarInput == 'male') {
      return 'male';
    } else if (genderBarInput == 'Female' || genderBarInput == 'female') {
      return 'female';
    } else {
      return 'male,female';
    }
  }

  String evaluateAgeInput(String ageBarInput) {
    if (ageBarInput == 'baby' || ageBarInput == 'Baby') {
      return 'baby';
    } else if (ageBarInput == 'young' || ageBarInput == 'Young') {
      return 'young';
    } else if (ageBarInput == 'adult' || ageBarInput == 'Adult') {
      return 'adult';
    } else if (ageBarInput == 'senior' || ageBarInput == 'Senior') {
      return 'senior';
    } else {
      return 'baby,young,adult,senior';
    }
  }

  String evaluateSpeciesInput(String speciesInputBody) {
    if (speciesInputBody == 'dog' || speciesInputBody == 'Dog') {
      return 'dog';
    } else if (speciesInputBody == 'cat' || speciesInputBody == 'Cat') {
      return 'cat';
    } else if (speciesInputBody == 'bird' || speciesInputBody == 'Bird') {
      return 'bird';
    } else if (speciesInputBody == 'horse' || speciesInputBody == 'Horse') {
      return 'horse';
    } else if (speciesInputBody == 'rodent' || speciesInputBody == 'Rodent') {
      return 'small-furry';
    } else if (speciesInputBody == 'rabbit' || speciesInputBody == 'Rabbit') {
      return 'rabbit';
    } else if (speciesInputBody == 'reptile' || speciesInputBody == 'Reptile') {
      return 'scales-fins-other';
    } else if (speciesInputBody == 'barnyard' ||
        speciesInputBody == 'Barnyard') {
      return 'barnyard';
    } else {
      return 'blank';
    }
  }

  GenderType evaluateGender(petListedGender) {
    switch (petListedGender) {
      case 'Male':
        return GenderType.male;
      default:
        return GenderType.female;
    }
  }

  AgeType evaluateAge(petListedAge) {
    switch (petListedAge) {
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

  SpeciesType evaluateSpecies(petListedSpecies) {
    switch (petListedSpecies) {
      case 'Dog':
        return SpeciesType.dog;
      case 'Cat':
        return SpeciesType.cat;
      case 'Small-furry' ||'Small & Furry'|| 'Rat' || 'Gerbil' || 'Guinea Pig':
        return SpeciesType.rodent;
      case 'Barnyard' || 'Goat' || 'Pot Bellied':
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
