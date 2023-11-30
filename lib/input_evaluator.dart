class InputEvaluator{
  final possibleGenderInputs={{'Male','male'},{'Female','female'},{'',' '}};
  String inspectGenderInput(String genderBarInput){
    if(genderBarInput=='Male' || genderBarInput=='male'){
      return 'Male';
    }
    else if(genderBarInput=='Female' || genderBarInput=='female'){
      return 'Female';
    } else{
      return 'male,female';
    }
  }

  inspectAgeInput(String ageBarInput) {
    if(ageBarInput=='baby'||ageBarInput=='Baby'){
      return'Baby';
    } else if(ageBarInput=='young'|| ageBarInput=='Young'){
      return 'Young';
    }else if(ageBarInput=='adult'|| ageBarInput=='Adult'){
      return 'Adult';
    } else{
      return'Senior';
    }
  }
}