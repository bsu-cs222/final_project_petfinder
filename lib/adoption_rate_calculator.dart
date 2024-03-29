import 'package:cs222_final_project_pet_finder/api_caller.dart';
import 'package:cs222_final_project_pet_finder/pet.dart';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:cs222_final_project_pet_finder/query_constructor.dart';

class AdoptionRateCalculator {
  Future<int> returnYearlyRate(Pet pet) async {
    final caller = ApiCaller();
    final query = QueryConstructor();
    final parser = PetFinderParser();

    final adoptedPetData =
        await caller.makeRequestToAPI(query.constructAdoptionQuery(pet, 'adopted'));
    final totalAdopted = parser.parseTotalResults(adoptedPetData);

    final adoptablePetData =
        await caller.makeRequestToAPI(query.constructAdoptionQuery(pet, 'adoptable'));
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
