import 'package:cs222_final_project_pet_finder/pet.dart';

class EnumDecoder {
  String decodeGenderEnum(GenderType petGender) {
    if (petGender == GenderType.male) {
      return 'Male';
    }
    if (petGender == GenderType.female) {
      return 'Female';
    } else {
      return 'male,female';
    }
  }

  String decodeAgeEnum(AgeType petAge) {
    if (petAge == AgeType.baby) {
      return 'Baby';
    } else if (petAge == AgeType.young) {
      return 'Young';
    } else if (petAge == AgeType.adult) {
      return 'Adult';
    } else {
      return 'Senior';
    }
  }

  String decodeSpeciesEnum(SpeciesType petSpecies) {
    if (petSpecies == SpeciesType.cat) {
      return 'Cat';
    } else if (petSpecies == SpeciesType.dog) {
      return 'Dog';
    } else if (petSpecies == SpeciesType.rabbit) {
      return 'Rabbit';
    } else if (petSpecies == SpeciesType.horse) {
      return 'Horse';
    } else if (petSpecies == SpeciesType.barnyard) {
      return 'Barnyard';
    } else if (petSpecies == SpeciesType.bird) {
      return 'Bird';
    } else if (petSpecies == SpeciesType.rodent) {
      return 'Rodent';
    } else {
      return 'Reptile';
    }
  }
}
