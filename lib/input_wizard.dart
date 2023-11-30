import 'package:cs222_final_project_pet_finder/input_evaluator.dart';
import 'package:flutter/material.dart';

class InputWizard{
  final inputEvaluator = InputEvaluator();
  String organizeGenderInput(TextEditingController genderController){
    String genderInputBody=genderController.text;
    String genderResult=inputEvaluator.inspectGenderInput(genderInputBody);
    return(genderResult);

  }
  String organizeAgeInput(TextEditingController ageController){
    String ageInputBody=ageController.text;
    String ageResult=inputEvaluator.inspectAgeInput(ageInputBody);
    return (ageResult);
  }
}