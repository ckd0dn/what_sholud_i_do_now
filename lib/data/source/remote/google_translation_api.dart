import 'dart:convert';

import 'package:http/http.dart' as http;

class GoogleTranslationApi {

  final http.Client _client;

  GoogleTranslationApi({http.Client? client}) : _client = (client ?? http.Client());

  //구글 번역 api
  Future<String> getTranslationGoogle(String text) async {
    var baseUrl = 'https://translation.googleapis.com/language/translate/v2';
    var key = 'AIzaSyDxRWl0MJoZzUaLMKjinaUM1qwRoOb60Ic';
    var to = "ko";
    var response = await _client.post(
      Uri.parse('$baseUrl?target=$to&key=$key&q=$text'),
    );

    if (response.statusCode == 200) {
      var dataJson = jsonDecode(response.body);
      String result =
      dataJson['data']['translations'][0]['translatedText'];
      return result;
    } else {
      return text;
    }
  }

}

