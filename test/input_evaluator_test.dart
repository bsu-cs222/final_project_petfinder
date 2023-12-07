import 'package:cs222_final_project_pet_finder/data_evaluator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final inputEvaluator = DataEvaluator();
  List<String> testingGenderInputs = ['Female', 'Male,Female', 'fmale'];
  List<String> expectedGenderInputs = ['female', 'male,female', 'male,female'];
  int index = 0;
  String result;
  for (String testingGender in testingGenderInputs) {
    test(
        'When given the input ${testingGenderInputs[index]} the evaluator reads it as ${expectedGenderInputs[index]}',
        () {
      result = inputEvaluator.evaluateGenderInput(testingGender);
      String expectedGender = expectedGenderInputs[index];
      expect(result, expectedGender);
      index++;
    });
  }
  final ageTestInputs = {'baby', 'young', 'adult', 'senior', 'alutd'};
  final expectedTestInputs = {
    'baby',
    'young',
    'adult',
    'senior',
    'baby,young,adult,senior'
  };
  int ageCounter = 0;
  for (var ageInput in ageTestInputs) {
    String currentAgeInput = ageInput;
    test('When given input young the evaluator reads it as $currentAgeInput',
        () {
      final result = inputEvaluator.evaluateAgeInput(currentAgeInput);
      expect(result, expectedTestInputs.elementAt(ageCounter));
      ageCounter++;
    });
  }
  test('When given input cat the evaluator reads it as cat', () {
    String species = 'Cat';
    final result = inputEvaluator.evaluateSpeciesInput(species);
    expect(result, 'cat');
  });
}
