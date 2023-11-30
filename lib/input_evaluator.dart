class InputEvaluator{
  String inspectGenderInput(String genderBarInput){
    if(genderBarInput=='Male' || genderBarInput=='male'){
      return 'male';
    }
    else if(genderBarInput=='Female' || genderBarInput=='female'){
      return 'female';
    } else{
      return 'male,female';
    }
  }

  inspectAgeInput(String ageBarInput) {
    if(ageBarInput=='baby'||ageBarInput=='Baby'){
      return'baby';
    } else if(ageBarInput=='young'|| ageBarInput=='Young'){
      return 'young';
    }else if(ageBarInput=='adult'|| ageBarInput=='Adult'){
      return 'adult';
    } else if(ageBarInput=='senior'||ageBarInput=='Senior'){
      return'senior';
    }
    else{
      return'baby,young,adult,senior';
    }
  }
}