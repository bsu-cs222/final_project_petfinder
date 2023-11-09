import 'dart:convert';
import 'package:http/http.dart' as http;


class Pet {
  final String name;
  final String species;
  final String breed;
  final String urlString;
  final List photos;
 final String zipcode;

  Pet(
      {required this.name,
      required this.species,
      required this.breed,
      required this.urlString,
      required this.photos,
      required this.zipcode
      }
      );
}

class QueryBuilder {
  Future<Map<String, String>> tokenQueryBuilder(id, secret) async {

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
}

class QueryCall {
  Future<Object> makeRequestToAPI(id, secret, String zipcode) async {
    final query = QueryBuilder();

    final response = await http.post(
      Uri.parse('https://api.petfinder.com/v2/oauth2/token'),
      body: await query.tokenQueryBuilder(id, secret),
    );
    if (response.statusCode == 200) {
      final queryResponse = await http.get(
        Uri.parse(
            'https://api.petfinder.com/v2/animals/?limit=5&distance=50&status=adoptable&location=$zipcode'),
        headers: query.petFinderCallBuilder(response),
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
      return Pet(
        name: listOfReturnedAnimals[index]['name'],
        species: listOfReturnedAnimals[index]['species'],
        breed: listOfReturnedAnimals[index]['breeds']['primary'],
        urlString: listOfReturnedAnimals[index]['url'],
        photos: listOfReturnedAnimals[index]['photos'],
        zipcode: listOfReturnedAnimals[index]['contact']['address']['postcode'],
      );
    });

    return pets;
  }
}
