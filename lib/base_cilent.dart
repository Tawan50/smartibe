import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smartibe/user.dart';
import 'package:smartibe/datadis.dart';

class BaseClient {
  String baseUrl = 'http://project.chs.ac.th:3030/api/';

  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      //throw Exception('Failed');
      return false;
    }
  }

  Future<dynamic> post(String api, User user) async {
    var url = Uri.parse(baseUrl + api);
    var response = await http.post(url,
        body: jsonEncode(user.toJson()),
        headers: <String, String>{'Content-Type': 'application/json'});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      //throw Exception('Failed');
      return false;
    }
  }

  Future<dynamic> send(String api, Datadis datadis) async {
    var url = Uri.parse(baseUrl + api);
    var response = await http.post(url,
        body: jsonEncode(datadis.toJson()),
        headers: <String, String>{'Content-Type': 'application/json'});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      //throw Exception('Failed');
      return false;
    }
  }
}