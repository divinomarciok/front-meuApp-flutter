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
}
