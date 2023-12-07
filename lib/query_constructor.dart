import 'dart:convert';

import 'package:cs222_final_project_pet_finder/enum_decoder.dart';
import 'package:cs222_final_project_pet_finder/data_evaluator.dart';
import 'package:cs222_final_project_pet_finder/pet.dart';

class TokenRequestor {
  Future<Map<String, String>> constructQueryForToken(id, secret) async {
    final Map<String, String> tokenResponse = {
      'grant_type': 'client_credentials',
      'client_id': '$id',
      'client_secret': '$secret',
    };
    return (tokenResponse);
  }
}

class QueryConstructor {
  Map<String, String> constructQueryHeader(tokenResponse) {
    final Map<String, dynamic> decodedTokenResponse =
    json.decode(tokenResponse.body);
    final String accessToken = decodedTokenResponse['access_token'];
    final Map<String, String> header = {
      'Authorization': 'Bearer $accessToken',
    };
    return (header);
  }
  String constructAdoptionQuery(Pet pet, String status) {
    final enumDecoder = EnumDecoder();
    final evaluator = DataEvaluator();
    DateTime currentDate = DateTime.now();
    DateTime oneYearAgo = currentDate.subtract(const Duration(days: 365));
    final formattedDate = '${oneYearAgo.toIso8601String()}Z';
    String species = enumDecoder.decodeSpeciesEnum(pet.species);
    species = evaluator.evaluateSpeciesInput(species);
    final breed = pet.breed.replaceAll(' ', '-');
    return 'https://api.petfinder.com/v2/animals/?after=$formattedDate&status=$status&type=$species&breed=$breed&location=46241&distance=50';
  }

  String addFilter(Map filters, String url) {
    for (final filter in filters.entries) {
      if (filter.value != 'blank') {
        url += '&${filter.key}=${filter.value}';
      }
    }
    return url;
  }

  String returnBaseURL() {
    return 'https://api.petfinder.com/v2/animals/?limit=100&status=adoptable';
  }
}
