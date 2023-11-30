import 'package:cs222_final_project_pet_finder/pet.dart';
class EnumDecoder{
  String decodeGenderEnum(GenderType petGender){
    if(petGender==GenderType.male){
      return'Male';
    }
    if(petGender==GenderType.female){
      return'Female';
    }
    else {
      return 'male,female';
    }}
  String decodeAgeEnum(AgeType petAge){
    if (petAge==AgeType.baby){
      return 'Baby';
    }else if(petAge==AgeType.young){
      return'Young';
    }else if (petAge==AgeType.adult){
      return'Adult';
    }
    else{
      return'Senior';
    }
  }
}