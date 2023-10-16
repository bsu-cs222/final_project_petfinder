import 'dart:convert';
import 'package:http/http.dart' as http;

class PetFinderParser {
  Future<String> makeRequestToAPI() async {
    const String clientId =
        'WP27Mq8UDXUpKodCbHgDRHGIvTaz7pTfTTHPPP8ZBzOJrlO3AZ';
    const String clientSecret = 'Ana1nynvKNyQtKbJAm5mTQISlrtaaYeA8ao4gjm3';
    const String apiUrl = 'https://api.petfinder.com/v2/oauth2/token';

    final Map<String, String> requestBody = {
      'grant_type': 'client_credentials',
      'client_id': clientId,
      'client_secret': clientSecret,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String accessToken = data['access_token'];
      final queryResponse = await http.get(
        Uri.parse('https://api.petfinder.com/v2/animals/?limit=1&type=rabbit'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      final Map<String, dynamic> apiResponse = json.decode(queryResponse.body);
      final animal = apiResponse['animals'][0]['species'];
      return (animal);
    } else {
      return ('Error: ${response.statusCode}');
    }
  }

  Future<String> findFive(queryResponse) async {
    // const String clientId = 'WP27Mq8UDXUpKodCbHgDRHGIvTaz7pTfTTHPPP8ZBzOJrlO3AZ';
    // const String clientSecret = 'Ana1nynvKNyQtKbJAm5mTQISlrtaaYeA8ao4gjm3';
    // const String apiUrl = 'https://api.petfinder.com/v2/oauth2/token';
    //
    // final Map<String, String> requestBody = {
    //   'grant_type': 'client_credentials',
    //   'client_id': clientId,
    //   'client_secret': clientSecret,
    // };
    //
    // final response = await http.post(
    //   Uri.parse(apiUrl),
    //   body: requestBody,
    // );
    //
    // if (response.statusCode == 200) {
    //   final Map<String, dynamic> data = json.decode(response.body);
    //   final String accessToken = data['access_token'];
    //   final queryResponse = await http.get(
    //     Uri.parse('https://api.petfinder.com/v2/animals/?limit=5&location=Indiana'),
    //     headers: {
    //       'Authorization': 'Bearer $accessToken',
    //     },
    //   );
    final apiResponse = json.decode(queryResponse);
    //print(apiResponse);
    final animals = apiResponse['animals'];
    return (animals);
    // for (var animal in animals){
    //   return(animal);
    // }
    //   } else {
    //     print('Error: ${response.statusCode}');
    //   }
  }
}
