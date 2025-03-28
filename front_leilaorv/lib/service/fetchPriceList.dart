import 'dart:convert';
import 'package:front_leilaorv/models/prices.dart';

import '../models/price_list.dart';
import 'package:dio/dio.dart';

class PriceListService {
  Future<List<PriceList>> getAllPriceListId(int id, String authorization ) async {
    var headers = {
      'Authorization':
          'Beraer $authorization',
    };
    var dio = Dio();
    var response = await dio.request(
      'http://localhost:8000/priceList/$id',
      options: Options(method: 'GET', headers: headers),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));

      List<PriceList> pricelistId =
          (response.data as List)
              .map((item) => PriceList.fromJson(item))
              .toList();

      return pricelistId;
    } else {
      print(response.statusMessage);

    }

   return throw Exception('Falha em carregar as empresas');
  }
}
