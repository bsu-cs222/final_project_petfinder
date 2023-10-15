import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';

void main() async{
  test ('When I enter 47306 I find data for the pets nearby', () async{
    final parser = PetFinderParser();
    final result = await parser.makeRequestToAPI();
    expect(result, 'Rabbit');
  });
}
