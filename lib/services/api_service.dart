import 'dart:convert';

import '../model/article_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

//Now let's make the HTTP request services
// this class will alows us to make a simple get http request
// from the API and get the Articles and then return a list of Articles

class ApiService {
  //let's add an Endpoint URL, you can check the website documentation
  // and learn about the different Endpoint
  //for this example I'm going to use a single endpoint
  static Future<Map<String, dynamic>> get(String baseUrl) async {
    debugPrint("BaseNetwork - fullUrl : $baseUrl");
    final response = await http.get(Uri.parse(baseUrl));
    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
      http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      print("processResponse error");
      return {"error": true};
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
  //NOTE: make sure to use your OWN apikey, you can make a free acount and
  // choose a developer option it's FREE

}
