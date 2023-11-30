enum GenderType { male, female}
//Any is not a possible answer to the filter. However the following
//try is not working either, although it should based on the API
class InputEvaluator{
  final possibleGenderInputs={{'Male','male'},{'Female','female'},{'',' '}};
  String inspectGenderInput(String genderBarInput){
    if(genderBarInput=='Male' || genderBarInput=='male'){
      return 'Male';
    }
    else if(genderBarInput=='Female' || genderBarInput=='female'){
      return 'Female';
    }else if(genderBarInput==' ' || genderBarInput==''){
      return 'male, female';
    }
    else{
      return 'male, female';
    }
  }
}