import 'package:cs222_final_project_pet_finder/input_evaluator.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){
  final inputEvaluator=InputEvaluator();
  test ('When given the input female the evaluator reads it as Female',(){
    String gender='female';
    final result=inputEvaluator.inspectGenderInput(gender);
    expect(result,'Female');
  });
  test ('When given no input the evaluator read it as male,female',(){
    String gender= '';
    final result= inputEvaluator.inspectGenderInput(gender);
    expect(result,'male,female');
  });
  test('When given a misspelled input the evaluator reads it as male,female',(){
    String gender= 'fmale';
    final result= inputEvaluator.inspectGenderInput(gender);
    expect(result,'male,female');
  });
  final ageTestInputs={'baby','young','adult','senior','alutd'};
  final expectedTestInputs={'Baby','Young','Adult','Senior','baby,young,adult,senior'};
  int ageCounter=0;
  for(var ageInput in ageTestInputs) {
    String currentAgeInput=ageInput;
    test('When given input young the evaluator reads it as ${currentAgeInput}', () {
      String age = currentAgeInput;
      final result = inputEvaluator.inspectAgeInput(age);
      expect(result, expectedTestInputs.elementAt(ageCounter));
      ageCounter++;
    });
  }
}