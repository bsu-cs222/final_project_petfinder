import 'dart:convert';
import 'package:cs222_final_project_pet_finder/main.dart';
import 'package:http/http.dart' as http;

class Pet {
  final String name;
  final String species;
  final String breed;
  final String URLString;
  final List photos;
  final List videos;
  final zipcode;

  Pet(
      {required this.name,
      required this.species,
      required this.breed,
      required this.URLString,
      required this.photos,
      required this.videos,
      required this.zipcode});
}

class QueryBuilder {
  Map<String, String> tokenQueryBuilder() {
    const String clientId =
        'WP27Mq8UDXUpKodCbHgDRHGIvTaz7pTfTTHPPP8ZBzOJrlO3AZ';
    const String clientSecret = 'Ana1nynvKNyQtKbJAm5mTQISlrtaaYeA8ao4gjm3';

    final Map<String, String> requestBody = {
      'grant_type': 'client_credentials',
      'client_id': clientId,
      'client_secret': clientSecret,
    };

    return (requestBody);
  }

  Map<String, String> PetFinderCallBuilder(tokenRequestResponse) {
    final Map<String, dynamic> decodedTokenRequestResponse =
        json.decode(tokenRequestResponse.body);
    final String accessToken = decodedTokenRequestResponse['access_token'];
    final Map<String, String> header = {
      'Authorization': 'Bearer $accessToken',
    };
    return (header);
  }
}

class QueryCall {
  Future<Object> makeRequestToAPI(String zipcode) async {
    final query = QueryBuilder();

    final response = await http.post(
      Uri.parse('https://api.petfinder.com/v2/oauth2/token'),
      body: query.tokenQueryBuilder(),
    );
    if (response.statusCode == 200) {
      final queryResponse = await http.get(
        Uri.parse(
            'https://api.petfinder.com/v2/animals/?limit=5&location=${zipcode}'),
        headers: query.PetFinderCallBuilder(response),
      );
      return (queryResponse.body);
    } else {
      return ('Error: ${response.statusCode}');
    }
  }
}

class PetFinderParser {
  List parseFivePets(queryResponse) {
    final decodedAPIResponse = json.decode(queryResponse);
    final listOfReturnedAnimals = decodedAPIResponse['animals'];
    List<Pet> pets = List<Pet>.generate(5, (index) {
      print(listOfReturnedAnimals[index]['contact']['address']['postcode']);
      return Pet(
        name: listOfReturnedAnimals[index]['name'],
        species: listOfReturnedAnimals[index]['species'],
        breed: listOfReturnedAnimals[index]['breeds']['primary'],
        URLString: listOfReturnedAnimals[index]['url'],
        photos: listOfReturnedAnimals[index]['photos'],
        videos: listOfReturnedAnimals[index]['videos'],
        zipcode: listOfReturnedAnimals[index]['contact']['address']['postcode'],
      );
    });

    return pets;
  }
}
