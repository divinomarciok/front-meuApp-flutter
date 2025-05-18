import 'package:flutter/material.dart';
import 'package:front_leilaorv/data/providers/auth.provider.dart';
import 'package:front_leilaorv/models/pricelist.dart';
import 'package:front_leilaorv/service/services.pricelist.dart';
import 'package:provider/provider.dart';
import './screen.addprice.product.dart';

class product_priceList extends StatefulWidget {
  final String id;
  final String? img_url;
  

  const product_priceList({
    super.key,
    required this.id,   
    this.img_url,
  });
  @override
  State<StatefulWidget> createState() => _product_priceList();
}

late Future<List<PriceList>> priceListFuture;

class _product_priceList extends State<product_priceList> {
  late Future<List<PriceList>> _priceListFuture;
  PriceListService _priceListService = PriceListService();

  late String token;

  late String id;
  late String imgUrl;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    imgUrl = widget.img_url!;
    token = Provider.of<AuthProvider>(context, listen: false).token;

    _priceListFuture = _priceListService.getAllPriceListId(
      int.parse(id),
      token,
    );
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
          /* if (snapshot.hasError) {
            return Text("Erro : ${snapshot.error}");
          }
          if (!snapshot.hasData) {
            return Text("Sem dados price list");
          }*/
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
                                        authorization: token,
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
                                        token,
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
                          itemCount: priceList?.length ?? 0,
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
                                        Text(
                                          '${priceList?[index].product.weigth} ${priceList?[index].product.unidade_measure}',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
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
