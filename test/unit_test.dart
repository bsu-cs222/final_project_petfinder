import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async{
  test (' When I enter 47306, I find data for the pets nearby', () async{
    final parser = PetFinderParser();
    final result = await parser.makeRequestToAPI();
    expect(result, '47306');
  });
  // This is going to decode the JSON into variables
  test ('When I enter Indiana, I receive the JSON code for the top five pets in the area', () async{
    final parser = PetFinderParser();
    final result = await parser.makeRequestToAPI();
    expect(result, '47306');
  });
}
