import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/enterprise.dart';
import 'package:dio/dio.dart';

class EnterpriseService {
  Future<dynamic> getAllEnterprise() async {
    var headers = {
      'Authorization':
          'Beraer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibG9naW4iOiJhY2Vyb2xhIiwiaWF0IjoxNzQzMDkxODkwLCJleHAiOjE3NDMwOTU0OTB9.8kajdx6LUHnCHo6AeZFAo81yUc9xRAegFzG__Z1xAJI',
    };
    var dio = Dio();
    var response = await dio.request(
      'http://localhost:8000/getEnterprises',
      options: Options(method: 'GET', headers: headers),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }

    /*Future<List<Enterprise>> fetchEnterprises() async {
    final response = await http.get(
      Uri.parse(''),
      headers: {
        'Authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibG9naW4iOiJhY2Vyb2xhIiwiaWF0IjoxNzQzMDg5MjY1LCJleHAiOjE3NDMwOTI4NjV9.WKvuEa1hOr4vCNLXZCnSnN7ilzu7Z1HbMKcNJg12i0g',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      print(body);
      List<Enterprise> enterprises =
          body.map((dynamic item) => Enterprise.fromJson(item)).toList();
      return enterprises;
    } else {
      throw Exception('Falha em carregar as empresas');
    }
  }*/
  }
}
