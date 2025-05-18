import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../models/products.dart';

class ProductService {
  final String baseUrl = 'http://localhost:8000/api';

  Future<List<Product>> getAllProduct(String authorization) async {
    var headers = {'Authorization': 'Bearer $authorization'};
    var dio = Dio();
    var response = await dio.request(
      'http://localhost:8000/api/products',
      options: Options(method: 'GET', headers: headers),
    );

    if (response.statusCode == 200) {
      List<Product> products =
          (response.data as List)
              .map((item) => Product.fromJson(item))
              .toList();
      return products;
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }

  Future<Product> addProduct(
    String authorization,
    String name,
    String mark,
    String weight,
    String unitMeasure,
    bool isSale,
    XFile? pickedFile,
  ) async {
    var dio = Dio();

    try {
      FormData formData;

      if (pickedFile != null) {
        // Lê o arquivo como bytes
        List<int> bytes = await pickedFile.readAsBytes();
        print("Enviando imagem: ${pickedFile.name}");
        print("Tamanho da imagem em bytes: ${bytes.length}");

        // Determina o tipo MIME com base na extensão do arquivo
        String mimeType = 'image/jpeg'; // Padrão
        if (pickedFile.name.endsWith('.png')) mimeType = 'image/png';
        if (pickedFile.name.endsWith('.gif')) mimeType = 'image/gif';
        if (pickedFile.name.endsWith('.webp')) mimeType = 'image/webp';
        if (pickedFile.name.endsWith('.jpg')) mimeType = 'image/jpg';
        formData = FormData.fromMap({
          'name': name,
          'mark': mark,
          'weigth': weight,
          'unidade_measure': unitMeasure,
          'is_sale': isSale ? 1 : 0, // Convertendo para número
          // Use 'image' como nome do campo para corresponder ao esperado pelo multer
          'image': await MultipartFile.fromBytes(
            bytes,
            filename: pickedFile.name,
            contentType: MediaType.parse(mimeType),
          ),
        });
      } else {
        formData = FormData.fromMap({
          'name': name,
          'mark': mark,
          'weigth': weight,
          'unidade_measure': unitMeasure,
          'is_sale': isSale ? 1 : 0,
        });
      }

      var response = await dio.post(
        'http://localhost:8000/api/products',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $authorization',
            // Remova o Content-Type para que o Dio defina automaticamente
          },
          validateStatus: (status) => status! < 500, // Para capturar erros 4xx
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        print('Resposta do servidor: ${response.data}');
        throw Exception(
          'Falha ao adicionar produto: ${response.statusCode} - ${response.statusMessage}',
        );
      }
    } catch (e) {
      print('Erro detalhado: $e');
      throw Exception('Erro ao adicionar produto: $e');
    }
  }
}
