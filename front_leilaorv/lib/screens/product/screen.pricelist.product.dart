import 'package:flutter/material.dart';
import 'package:front_leilaorv/models/pricelist.dart';
import 'package:front_leilaorv/service/services.pricelist.dart';
import './screen.addprice.product.dart';

class product_priceList extends StatefulWidget {
  final String id;
  final String authorization;
  final String? img_url;

  const product_priceList({
    super.key,
    required this.id,
    required this.authorization,
    this.img_url,
  });
  @override
  State<StatefulWidget> createState() => _product_priceList();
}

late Future<List<PriceList>> priceListFuture;

class _product_priceList extends State<product_priceList> {
  late Future<List<PriceList>> _priceListFuture;
  PriceListService _priceListService = PriceListService();

  late String authorization;
  late String id;
  late String imgUrl;

  @override
  void initState() {
    id = widget.id;
    authorization = widget.authorization;
    imgUrl = widget.img_url!;

    _priceListFuture = _priceListService.getAllPriceListId(
      int.parse(id),
      authorization,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Preço dos  Produtos"),
        backgroundColor: Colors.lightGreen,
      ),
      body: FutureBuilder(
        future: _priceListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("Erro : ${snapshot.error}");
          }
          if (!snapshot.hasData) {
            return Text("Sem dados price list");
          }
          final priceList = snapshot.data;

          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Card(
                elevation: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 4.0,
                      child: Image.network(
                        height: 400,
                        'http://localhost:8000/uploads/${imgUrl}',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          width: 600,
                          child: ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => AddPriceScreen(
                                        productId: id,
                                        authorization: authorization,
                                        productName:
                                            priceList?.isNotEmpty == true
                                                ? priceList![0].product.name
                                                : "Produto",
                                        productImage: imgUrl,
                                      ),
                                ),
                              );

                              // Se retornou com sucesso, recarrega os preços
                              if (result == true) {
                                setState(() {
                                  _priceListFuture = _priceListService
                                      .getAllPriceListId(
                                        int.parse(id),
                                        authorization,
                                      );
                                });
                              }
                            },
                            child: Text('Adiciona Preço Produto'),
                          ),
                        ),
                      ),
                    ),

                    Center(
                      child: SizedBox(
                        height: 690,
                        width: 600,
                        child: ListView.builder(
                          itemCount: priceList?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 4,
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Empresa (destacada)
                                    Text(
                                      '${priceList?[index].enterprise.name}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Informações em linhas com labels
                                    Row(
                                      children: [
                                        const Text(
                                          'Preço: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'R\$ ${priceList?[index].price}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),

                                    Row(
                                      children: [
                                        /* const Text(
                                          'Quantidade: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),*/
                                        Text(
                                          '${priceList?[index].product.weigth} ${priceList?[index].product.unidade_measure}',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),

                                    /*Row(
                                      children: [
                                        const Text(
                                          'Marca: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${priceList?[index].product.mark}',
                                        ),
                                      ],
                                    ),*/
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    /*  Center(
                      child: SizedBox(
                        height: 690,
                        width: 600,
                        child: ListView.builder(
                          itemCount: priceList?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  Text(
                                    ' ${priceList?[index].enterprise.name} \nR\$:${priceList?[index].price} \n${priceList?[index].product.weigth} : ${priceList?[index].product.unidade_measure} \n${priceList?[index].product.mark}',
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
