import 'dart:convert';

import 'package:front_leilaorv/models/products.dart';
import 'package:dio/dio.dart';

class ProductService {
  Future<List<Product>> getAllProduct(String authorization) async {
    try {
      var headers = {'Authorization': 'Bearer $authorization'};

      var dio = Dio();
      var response = await dio.request(
        'http://localhost:8000/api/products',
        options: Options(method: 'GET', headers: headers),
      );

      if (response.statusCode == 200) {
        print(response.data);
        List<Product> productList =
            (response.data as List)
                .map((item) => Product.fromJson(item))
                .toList();

        return productList;
      } else {
        print(response.statusMessage);
        throw Exception('Falha em carregar as produtos');
      }
    } catch (e) {
      print('Erro na requisição: $e');
      if (e is DioException) {
        print('DioError: ${e.message}');
        print('Response: ${e.response?.data}');
      }
      throw Exception('Falha ao carregar os produtos: $e');
    }
  }

  // Adicione este método ao seu ProductService existente

  Future<Product> addProduct(
    String authorization,
    String name,
    String mark,
    String weight,
    String unitMeasure,
    bool isSale,
    // Adicione parâmetros para imagem se necessário
  ) async {
    var headers =  {'Authorization': 'Bearer $authorization'};
   
    var data = FormData.fromMap({
      'files': [
        await MultipartFile.fromFile(
          '/C:/Users/divin/OneDrive/Desktop/imagens/cerveja heineken long neck 330ml.jpg',
          filename:
              '/C:/Users/divin/OneDrive/Desktop/imagens/cerveja heineken long neck 330ml.jpg',
        ),
      ],
      'name': 'Longneck Heineken 330ml',
      'mark': 'Heineken ',
      'category': '6',
      'description': 'Bebida alcolica',
      'unidade_measure': 'L',
      'weigth': '0.330',
    });

    var dio = Dio();
    var response = await dio.request(
      'http://localhost:8000/api/products',
      options: Options(method: 'POST', headers: headers),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      return response.data;
    } else {
      print(response.statusMessage);
      throw Exception('Falha ao criar o produto ');

    }
  }
}
