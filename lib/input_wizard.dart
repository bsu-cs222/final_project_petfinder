
import 'package:cs222_final_project_pet_finder/input_evaluator.dart';
import 'package:flutter/material.dart';

class InputWizard{
  final inputEvaluator = InputEvaluator();
  String organizeGenderInput(TextEditingController genderController){
    String genderInputBody=genderController.text;
    String genderResult=inputEvaluator.inspectGenderInput(genderInputBody);
    if(genderResult=='Error'){
      return ('male, female'); //COME BACK because eventually we'll be running the method builder from here, WE CAN'T DO THAT NOW CAUSE DESTINY IS DOING METHOD CALLS SO UNTIL THEN WE RUN IT LIKE THIS -Sol
    }
    else{
    return(genderResult);}

  }
}