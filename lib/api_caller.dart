import 'package:cs222_final_project_pet_finder/query_builder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class APICaller {
  Future<Object> makeRequestToAPI(urlFinal) async {
    final query = QueryBuilder();
    final response = await http.post(
      Uri.parse('https://api.petfinder.com/v2/oauth2/token'),
      body: await query.constructTokenQuery(dotenv.env['api_id'],
          dotenv.env['api_secret']),
    );
    if (response.statusCode == 200) {
      final queryResponse = await http.get(
        Uri.parse('$urlFinal'),
        headers: query.petFinderCallBuilder(response),
      );
      return (queryResponse.body);
    } else {
      //We need to add exceptions.
      return ('Error: ${response.statusCode}');
    }
  }
}