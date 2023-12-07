import 'package:cs222_final_project_pet_finder/api_caller.dart';
import 'package:cs222_final_project_pet_finder/enum_decoder.dart';
import 'package:cs222_final_project_pet_finder/input_evaluator.dart';
import 'package:cs222_final_project_pet_finder/pet.dart';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';

class AdoptionRateCalculator {
  String pullAdoptionData(Pet pet, String status) {
    final enumDecoder = EnumDecoder();
    final evaluator = InputEvaluator();
    DateTime currentDate = DateTime.now();
    DateTime oneYearAgo = currentDate.subtract(const Duration(days: 365));
    final formattedDate = '${oneYearAgo.toIso8601String()}Z';
    String species = enumDecoder.decodeSpeciesEnum(pet.species);
    species = evaluator.evaluateSpeciesInput(species);
    final breed = pet.breed.replaceAll(' ', '-');
    return 'https://api.petfinder.com/v2/animals/?after=$formattedDate&status=$status&type=$species&breed=$breed&location=46241&distance=50';
  }

  Future<int> returnYearlyRate(Pet pet) async {
    final caller = ApiCaller();
    final parser = PetFinderParser();

    final adoptedPetData =
        await caller.makeRequestToAPI(pullAdoptionData(pet, 'adopted'));
    final totalAdopted = parser.parseTotalResults(adoptedPetData);

    final adoptablePetData =
        await caller.makeRequestToAPI(pullAdoptionData(pet, 'adoptable'));
    final totalAdoptable = parser.parseTotalResults(adoptablePetData);

    final yearlyRate = calculateAdoptionRate(totalAdopted, totalAdoptable);
    return (yearlyRate);
  }

  int calculateAdoptionRate(int adopted, int adoptable) {
    double rateAsDecimal = (adopted / (adopted + adoptable)) * 100;
    final rateAsPercentage = rateAsDecimal.round();
    return (rateAsPercentage);
  }
}
