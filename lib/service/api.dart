import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';

class CallApi {
  final String _url = baseurl + 'api';

  Future<http.Response> postData(data, String apiUrl) async {
    //var fullUrl = _url + apiUrl + await _getToken();
    final String fullUrl = _url + apiUrl;
    final Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'HttpHeaders.contentTypeHeader': 'application/json',
      'Authorization': await _getToken(),
    };
    return await http.post(fullUrl, body: jsonEncode(data), headers: header);
  }

  // ignore: always_specify_types
  Future<http.Response> getData(String apiUrl) async {
    assert(apiUrl != null);
    final String fullUrl = _url + apiUrl;
    final Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'HttpHeaders.contentTypeHeader': 'application/json',
      'Authorization': await _getToken(),
    };

    // print(fullUrl);
    return await http.get(fullUrl, headers: header);
  }

  Map<String, String> _setHeaders() => {
        'HttpHeaders.contentTypeHeader': 'application/json',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future<String> _getToken() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    final token = localStorage.getString('token');

    return 'Bearer $token';
  }

  Future<http.Response> getwebData(String apiUrl) async {
    assert(apiUrl != null);
    var fullUrl = apiUrl + await _getToken();
    return await http.get(fullUrl, headers: _setHeaders());
  }
}
