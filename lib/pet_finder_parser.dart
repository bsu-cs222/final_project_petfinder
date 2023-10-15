import 'dart:convert';
import 'package:http/http.dart' as http;

class PetFinderParser{
    void main(){
        makeRequestToAPI();
    }

    Future<void> makeRequestToAPI() async {
      const String clientId = 'YOUR_CLIENT_ID';
      const String clientSecret = 'YOUR_CLIENT_SECRET';
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
          Uri.parse('//api.petfinder.com/v2/animals/?{limit}={1}'),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );

        print(queryResponse.body);
      } else {
        print('Error: ${response.statusCode}');
      }


    }
}
