import 'dart:convert';
import '../models/enterprise.dart';
import 'package:dio/dio.dart';

class EnterpriseService {
  Future<List<Enterprise>> getAllEnterprise() async {
    var headers = {
      'Authorization':
          'Beraer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibG9naW4iOiJhY2Vyb2xhIiwiaWF0IjoxNzQzMTAxOTQ4LCJleHAiOjE3NDMxMDU1NDh9.sBfG-IAcUmW14iBOy8HiMMqJIitb5N9mbn1tlA_dCFM ',
    };
    var dio = Dio();
    var response = await dio.request(
      'http://localhost:8000/getEnterprises',
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
    return throw Exception('Falha em carregar as empresas');

  }
}
