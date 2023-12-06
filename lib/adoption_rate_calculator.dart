import 'package:cs222_final_project_pet_finder/api_caller.dart';
import 'package:cs222_final_project_pet_finder/pet.dart';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:cs222_final_project_pet_finder/query_builder.dart';

class AdoptionRateCalculator {
  Future<int> returnFinalRate(Pet pet) async {
    final caller = APICaller();
    final query = QueryBuilder();
    final parser = PetFinderParser();

    final adoptedPetData = await caller.makeRequestToAPI(query.pullAdoptionData(pet, 'adopted'));
    final totalAdopted = parser.parseTotalResults(adoptedPetData);

    final adoptablePetData =
        await caller.makeRequestToAPI(query.pullAdoptionData(pet, 'adoptable'));
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
