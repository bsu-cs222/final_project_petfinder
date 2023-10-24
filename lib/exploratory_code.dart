import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
void main() async{
    final caller = QueryCall();
    final parser = PetFinderParser();
    // final result = await parser.makeRequestToAPI();
    // print(result);

    // final File petTestFile = File('test/apiResponse.json');
    // final fileContents = petTestFile.readAsStringSync();
    // final results = parser.parseFivePets(fileContents);
    //
    // for (var result in results){
    //     print('${result.name} is a ${result.breed} ${result.species}.');
    // }
    final zipCode = "47306";
    final response = await caller.makeRequestToAPI(zipCode);
    final pets = parser.parseFivePets(response);
    print(pets);

}
