import 'package:cs222_final_project_pet_finder/data_evaluator.dart';
import 'package:flutter/material.dart';

class InputOrganizer {
  final inputEvaluator = DataEvaluator();
  bool organizeZipcodeInput(TextEditingController zipcodeController) {
    String zipcodeInputBody = zipcodeController.text;
    bool zipcodeResult = inputEvaluator.evaluateZipcodeInput(zipcodeInputBody);
    return (zipcodeResult);
  }

  String organizeGenderInput(TextEditingController genderController) {
    String genderInputBody = genderController.text;
    String genderResult = inputEvaluator.evaluateGenderInput(genderInputBody);
    return (genderResult);
  }

  String organizeAgeInput(TextEditingController ageController) {
    String ageInputBody = ageController.text;
    String ageResult = inputEvaluator.evaluateAgeInput(ageInputBody);
    return (ageResult);
  }

  String organizeSpeciesInput(TextEditingController speciesController) {
    String speciesInputBody = speciesController.text;
    String speciesResult =
        inputEvaluator.evaluateSpeciesInput(speciesInputBody);
    return (speciesResult);
  }
}
