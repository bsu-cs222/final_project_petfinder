//This class and file needs a better name still

import 'package:cs222_final_project_pet_finder/query_builder.dart';
import 'package:http/http.dart' as http;

class QueryCall{
  Future<Object> makeRequestToAPI(id, secret, urlFinal) async {
    final query = QueryBuilder();
    final response = await http.post(
      Uri.parse('https://api.petfinder.com/v2/oauth2/token'),
      body: await query.tokenQueryBuilder(id, secret),
    );
    if (response.statusCode == 200) {
      final queryResponse = await http.get(
        Uri.parse('$urlFinal'),
        headers: query.petFinderCallBuilder(response),
      );
      return (queryResponse.body);
    } else {
      //We need to add exceptions here
      return ('Error: ${response.statusCode}');
    }
  }
}