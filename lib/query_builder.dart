import 'dart:convert';

import 'package:cs222_final_project_pet_finder/enum_decoder.dart';
import 'package:cs222_final_project_pet_finder/input_evaluator.dart';
import 'package:cs222_final_project_pet_finder/pet.dart';

class QueryBuilder {
  Future<Map<String, String>> constructTokenQuery(id, secret) async {
    final Map<String, String> requestBody = {
      'grant_type': 'client_credentials',
      'client_id': '$id',
      'client_secret': '$secret',
    };
    return (requestBody);
  }

  Map<String, String> petFinderCallBuilder(tokenRequestResponse) {
    final Map<String, dynamic> decodedTokenRequestResponse =
    json.decode(tokenRequestResponse.body);
    final String accessToken = decodedTokenRequestResponse['access_token'];
    final Map<String, String> header = {
      'Authorization': 'Bearer $accessToken',
    };
    return (header);
  }

  String addFilter(Map filters, String url){
    for(final filter in filters.entries){
      if(filter.value!='blank') {
        url += '&${filter.key}=${filter.value}';
      }
    }
    return url;
  }

  String pullAdoptedFound(Pet pet){
    final enumDecoder = EnumDecoder();
    final evaluator = InputEvaluator();
    DateTime now = DateTime.now();
    DateTime oneMonthAgo = now.subtract(const Duration(days: 365));
    final formattedDate = '${oneMonthAgo.toIso8601String()}Z';
    String species = enumDecoder.decodeSpeciesEnum(pet.species);
    species = evaluator.inspectSpeciesInput(species);
    final breed = pet.breed.replaceAll(' ', '-');
    return 'https://api.petfinder.com/v2/animals/?after=$formattedDate&status=adopted&type=$species&breed=$breed&location=46241&distance=50';
  }
  String pullAdoptableFound(Pet pet){
    final enumDecoder = EnumDecoder();
    final evaluator = InputEvaluator();
    DateTime now = DateTime.now();
    DateTime oneMonthAgo = now.subtract(const Duration(days: 365));
    final formattedDate = '${oneMonthAgo.toIso8601String()}Z';
    String species = enumDecoder.decodeSpeciesEnum(pet.species);
    species = evaluator.inspectSpeciesInput(species);
    final breed = pet.breed.replaceAll(' ', '-');
    return 'https://api.petfinder.com/v2/animals/?status=adoptable&type=$species&breed=$breed&location=46241&distance=50&after=$formattedDate';
  }
  String pullBaseURL() {
    return 'https://api.petfinder.com/v2/animals/?limit=100&status=adoptable';
  }
}