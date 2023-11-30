
import 'package:cs222_final_project_pet_finder/input_evaluator.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  test ('When given the input female the evaluator reads it as Female',(){
    final inputEvaluator = InputEvaluator();
    String gender='female';
    final result=inputEvaluator.inspectGenderInput(gender);
    expect(result,'Female');
  });
  test ('When given no input the evaluator read it as Any',(){
    final inputEvaluator=InputEvaluator();
    String gender= '';
    final result= inputEvaluator.inspectGenderInput(gender);
    expect(result,'Any');
  });
  test('When given a misspelled input the evaluator reads it as Error',(){
    final inputEvaluator=InputEvaluator();
    String gender= 'fmale';
    final result= inputEvaluator.inspectGenderInput(gender);
    expect(result,'Error');
  });
}