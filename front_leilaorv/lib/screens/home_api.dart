import 'package:flutter/material.dart';
import 'package:front_leilaorv/models/price_list.dart';
//import 'package:front_leilaorv/service/fetchEnterprises.dart';
import 'package:front_leilaorv/service/fetchPriceList.dart';
//import '../models/enterprise.dart';

class leilaoHome extends StatefulWidget {
  const leilaoHome({super.key});
  @override
  State<leilaoHome> createState() => _leilaoHomeState();
}

late Future<List<PriceList>> enterprisesFuture;

class PriceListMock {
  static Future<List<PriceList>> getMockEnterprisesFuture() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      PriceList.fromJson({
        'nameProd': 'Smartphone X2000',
        'mark': 'TechBrand',
        'price': 799.99,
        'isSale': true,
        'enterprise': 'ElectroStore',
        'un': 1,
        'weigth': 0.2,
        'img_url': 'https://example.com/smartphone.jpg',
      }),
      PriceList.fromJson({
        'nameProd': 'Wireless Headphones Pro',
        'mark': 'SoundWave',
        'price': 199.50,
        'isSale': false,
        'enterprise': 'ElectroStore',
        'un': 1,
        'weigth': 0.1,
        'img_url': 'https://example.com/headphones.jpg',
      }),
      PriceList.fromJson({
        'nameProd': 'Laptop UltraBook',
        'mark': 'CompuTech',
        'price': 1299.00,
        'isSale': true,
        'enterprise': 'ElectroStore',
        'un': 1,
        'weigth': 1.5,
        'img_url': 'https://example.com/laptop.jpg',
      }),
      PriceList.fromJson({
        'nameProd': 'Smart Watch Series 5',
        'mark': 'TimeTrack',
        'price': 249.99,
        'isSale': false,
        'enterprise': 'ElectroStore',
        'un': 1,
        'weigth': 0.05,
        'img_url': 'https://example.com/smartwatch.jpg',
      }),
    ];
  }

  // Initialize the Future in the constructor or initState
}

class _leilaoHomeState extends State<leilaoHome> {
  late Future<List<PriceList>> _enterprisesFuture;
  final PriceListService _service = PriceListService();

  late int id = 1;
  late String authorization =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibG9naW4iOiJhY2Vyb2xhIiwiaWF0IjoxNzQzMTgwNjAyLCJleHAiOjE3NDMxODQyMDJ9.5YsLCpyppNhRo5dj8f5Eh2dkuXZzaGrPPZAVFlsvuFA";

  void initializeMockData() {
    _enterprisesFuture = PriceListMock.getMockEnterprisesFuture();
  }
  /*@override
  void initState() {
    super.initState();
    _enterprisesFuture = _service.getAllPriceListId(id, authorization);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Leilão Rio Verde"),
        backgroundColor: Colors.lightGreen,
      ),
      body: FutureBuilder<List<PriceList>>(
        future: _enterprisesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Erro : ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return Text('Sem dados priceList');
          }
          final enterprises = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(2),
                    itemCount: enterprises.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 200,
                        child: Card(
                          elevation: 4,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.network(
                                  'https://i1.wp.com/qrofertas.s3.us-west-2.amazonaws.com/imagens-ads/d0691886-4ea4-4e5b-bc76-ca1a9e680b38-modelo-de-encarte-4-tema-4159-pagina-1-art-82761.jpg?w=582',
                                  height: 280,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${enterprises[index].nameProd} \nMarca: ${enterprises[index].mark} \nR\$: ${enterprises[index].price} \n${enterprises[index].enterprise}",

                                  // "Produto $enterprises[index].nome \nR\$ 100,00 \nCategoria : Congelados \nMarca : Boa ",
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
