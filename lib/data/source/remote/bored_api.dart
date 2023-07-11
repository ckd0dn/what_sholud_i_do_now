import 'package:http/http.dart' as http;

class BoredApi {
  static const baseUrl = 'http://www.boredapi.com/api/activity/';

  final http.Client _client;

  BoredApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getActivity(String type, String participants, String price, String accessibility) async {

    Uri uri = Uri.parse('$baseUrl$type$participants$price$accessibility');

    final response = await _client.get(uri);


    if (response.statusCode == 200) {

      return response;
    } else {
      throw Exception('Failed to fetch random tings to do data');
    }

  }


}