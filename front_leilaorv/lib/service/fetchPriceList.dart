import 'dart:convert';
import '../models/price_list.dart';
import 'package:dio/dio.dart';

class PriceListService {
  Future<List<PriceList>> getAllPriceListId(
    int id,
    String authorization,
  ) async {
    var headers = {'Authorization': 'Beraer $authorization'};
    var dio = Dio();
    late Future<List<PriceList>> pricelistNull = Future.value([]);
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
      //throw Exception('Falha em carregar as price list');
      print("Produto sem dados de preço");
      return pricelistNull;
    }
  }
}
