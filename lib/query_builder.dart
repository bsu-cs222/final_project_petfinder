import 'dart:convert';

class TokenAuthenticator {
  Future<Map<String, String>> pullQueryToken(id, secret) async {
    final Map<String, String> tokenResponse = {
      'grant_type': 'client_credentials',
      'client_id': '$id',
      'client_secret': '$secret',
    };
    return (tokenResponse);
  }

  Map<String, String> authenticateTokenHeader(tokenResponse) {
    final Map<String, dynamic> decodedTokenResponse =
        json.decode(tokenResponse.body);
    final String accessToken = decodedTokenResponse['access_token'];
    final Map<String, String> header = {
      'Authorization': 'Bearer $accessToken',
    };
    return (header);
  }
}

class QueryBuilder {
  String addFilter(Map filters, String url) {
    for (final filter in filters.entries) {
      if (filter.value != 'blank') {
        url += '&${filter.key}=${filter.value}';
      }
    }
    return url;
  }

  String pullBaseURL() {
    return 'https://api.petfinder.com/v2/animals/?limit=100&status=adoptable';
  }
}
