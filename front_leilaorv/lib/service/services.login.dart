import 'package:dio/dio.dart';
import 'dart:convert';

class LoginService {
  Future<String> returnLogin(String login, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"login": login, "senha": password});
    var dio = Dio();
    var response = await dio.request(
      'http://localhost:8000/api/login',
      options: Options(method: 'POST', headers: headers),
      data: data,
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      final data = response.data;
      final String token = data['token'];
      print("Token : $token");

      return token;
    } else {
      print(response.statusMessage);
    }
    return throw Exception('Falha ao fazer login');
  }

  Future<bool> login(String login, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"login": login, "senha": password});
    var dio = Dio();
    var response = await dio.request(
      'http://localhost:8000/api/login',
      options: Options(method: 'POST', headers: headers),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      final data = response.data;

      final String token = data['token'];
      print("Token : $token");

      return true;
    } else {
      print(response.statusMessage);
    }
    return throw Exception('Falha ao fazer login');
  }
}
