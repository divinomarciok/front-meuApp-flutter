import 'dart:convert';
import '../models/pricelist.dart';
import 'package:dio/dio.dart';

class PriceListService {
  final String baseUrl = 'http://localhost:8000/api';

  Future<List<PriceList>> getAllPriceListId(
    int id,
    String authorization,
  ) async {
    List<PriceList> pricelistId = [];
    var headers = {'Authorization': 'Beraer $authorization'};
    var dio = Dio();
    late Future<List<PriceList>> pricelistNull = Future.value([]);
    var response = await dio.request(
      'http://localhost:8000/api/pricelists/product/$id',
      options: Options(method: 'GET', headers: headers),
    );
    if (response.statusCode == 200) {
      print(json.encode(response.data));

      if (response.data is List) {
        pricelistId =
            (response.data as List)
                .map((item) => PriceList.fromJson(item))
                .toList();
      } else {
        pricelistId = [];
      }
      return pricelistId;
    } else {
      //throw Exception('Falha em carregar as price list');
      print("Produto sem dados de preço");
      return pricelistId; 
    }
  }

  Future<bool> addPrice(
    String authorization,
    int productId,
    int enterpriseId,
    double price,
    bool isSale,
  ) async {
    var headers = {
      'Authorization': 'Bearer $authorization',
      'Content-Type': 'application/json',
    };

    var data = json.encode({
      "productId": productId,
      "price": price,
      "enterpriseId": enterpriseId,
    });
    var dio = Dio();
    var response = await dio.request(
      'http://localhost:8000/api/pricelists',
      options: Options(method: 'POST', headers: headers),
      data: data,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Falha ao adicionar preço: ${response.statusMessage}');
    }
  }
}
