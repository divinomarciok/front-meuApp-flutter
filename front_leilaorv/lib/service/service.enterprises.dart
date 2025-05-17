import 'dart:convert';
import '../models/enterprise.dart';
import 'package:dio/dio.dart';

class EnterpriseService {

  Future<List<Enterprise>> getAllEnterprise (String authorization) async {
    var headers = {
      'Authorization':
          'Beraer $authorization',
    };
    var dio = Dio();
    var response = await dio.request(
      'http://localhost:8000/api/enterprises',
      options: Options(method: 'GET', headers: headers),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));

      List<Enterprise> enterprises =
          (response.data as List)
              .map((item) => Enterprise.fromJson(item))
              .toList();

      return enterprises;
    } else {
      print(response.statusMessage);
    }
    return throw Exception('Falha em criar  empresas');
  }

  Future<Enterprise> addEnterprise(
    String authorization,
    String name,
    String address,
    String cep,
    String cnpj,
  ) async {
    var headers = {
      'Authorization': 'Bearer $authorization',
      'Content-Type': 'application/json',
    };
    var data = json.encode({
      "name": name,
      "address": address,
      "cep": cep,
      "cnpj": cnpj,
    });
    var dio = Dio();
    var response = await dio.request(
      'http://localhost:8000/api/enterprises',
      options: Options(method: 'POST', headers: headers),
      data: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(json.encode(response.data));
      return Enterprise.fromJson(response.data);
    } else {
      print(response.statusMessage);
      throw Exception('Falha ao adicionar empresa: ${response.statusMessage}');
    }
  }
}
