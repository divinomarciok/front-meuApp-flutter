import 'package:dio/dio.dart';
import 'dart:convert';

class LoginService {
  Future<String> returnLogin(String login, String password) async {

    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"login": "acerola", "senha": "123456"});
    var dio = Dio();
    var response = await dio.request(
      'http://localhost:8000/login',
      options: Options(method: 'POST', headers: headers),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));

      final data = response.data;

      final String token = data['token'];

      print("Token : $token");

      return token;
    } else {
      print(response.statusMessage);
    }
    return throw Exception('Falha ao fazer login');
  }
}
