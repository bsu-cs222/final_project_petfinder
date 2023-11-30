import 'dart:convert';

class QueryBuilder {
  Future<Map<String, String>> ConstructTokenQuery(id, secret) async {
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

  String orginalURL() {
    return 'https://api.petfinder.com/v2/animals/?distance=50&status=adoptable';
  }

  String addFilter(Map filters, String url){
    for(final filter in filters.entries){
      url += '&${filter.key}=${filter.value}';
    }
    print(url);
    return url;
  }
}