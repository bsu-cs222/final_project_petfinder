class InputEvaluator{
  bool inspectZipcodeInput(String zipcodeBarInput){
    if(zipcodeBarInput!=''){
      return true;
    }
    else{
      return false;
    }
  }
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

  String inspectSpeciesInput(String speciesInputBody) {
    if(speciesInputBody=='dog'|| speciesInputBody =='Dog'){
      return'dog';
    } else if(speciesInputBody=='cat'||speciesInputBody=='Cat'){
      return'cat';
    }else if(speciesInputBody=='bird'||speciesInputBody=='Bird'){
      return 'bird';
    }else if (speciesInputBody=='horse'||speciesInputBody=='Horse'){
      return 'horse';
    } else if (speciesInputBody=='rodent'||speciesInputBody=='Rodent'){
      return 'small-furry';
    } else if (speciesInputBody=='rabbit'||speciesInputBody=='Rabbit'){
      return 'rabbit';
    }
    else if (speciesInputBody=='reptile'||speciesInputBody=='Reptile'){
      return 'scales-fins-other';
    }else if (speciesInputBody=='barnyard'|| speciesInputBody=='Barnyard'){
      return 'barnyard';
    }
    else{
      return 'blank';
    }
  }
}