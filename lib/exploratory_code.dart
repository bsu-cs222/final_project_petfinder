import 'package:cs222_final_project_pet_finder/pet_finder_parser.dart';

void main() async{
    final parser = PetFinderParser();
    final result = await parser.makeRequestToAPI();
    print(result);
}
