import 'package:cs222_final_project_pet_finder/api_caller.dart';
import 'package:cs222_final_project_pet_finder/pet.dart';
import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:cs222_final_project_pet_finder/query_builder.dart';

class AdoptionRateCalculator {
  int calculateRate(int adopted, int adoptable) {
    double rateAsDecimal = (adopted / (adopted + adoptable)) * 100;
    final rateAsPercentage = rateAsDecimal.round();
    return (rateAsPercentage);
  }

  Future<int> returnFinalRate(Pet pet) async {
    final caller = APICaller();
    final query = QueryBuilder();
    final parser = PetFinderParser();

    final adopted = await caller.makeRequestToAPI(
        query.pullAdoptedFound(pet));
    final parsedAdopted = parser.parseAdoption(adopted);

    final adoptable = await caller.makeRequestToAPI(
        query.pullAdoptableFound(pet));
    final parsedAdoptable = parser.parseAdoption(adoptable);

    final yearlyRate = calculateRate(parsedAdopted, parsedAdoptable);
    return (yearlyRate);
  }
}