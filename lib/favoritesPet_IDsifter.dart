
import 'package:cs222_final_project_pet_finder/pet.dart';

class FavPetIDSifter{
  List<dynamic> findPetObjects(List<int> favoritedIDs, List<dynamic>pets){
    List<dynamic> favPets=[];
    for (int currentID in favoritedIDs){
      for(Pet pet in pets){
      int underInspectionPetId= pet.petID;
      if(currentID==underInspectionPetId){
        favPets.add(pet);
      }
    }}
    return favPets;
  }
}