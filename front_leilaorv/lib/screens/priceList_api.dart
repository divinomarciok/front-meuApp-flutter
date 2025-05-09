import 'package:flutter/material.dart';
import 'package:front_leilaorv/models/price_list.dart';
import 'package:front_leilaorv/service/fetchPriceList.dart';

class product_priceList extends StatefulWidget {
  final String id;
  final String authorization;
  final String img_url;

  const product_priceList({
    super.key,
    required this.id,
    required this.authorization,
    required String this.img_url,
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
    // TODO: implement initState
    id = widget.id;
    authorization = widget.authorization;
    imgUrl = widget.img_url;

    _priceListFuture = _priceListService.getAllPriceListId(
      int.parse(id),
      authorization,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              //color: Colors.cyan,
              alignment: Alignment.center,
              //height: 240,
              child: Card(
                elevation: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 4.0,
                      child: Image.network(
                        height: 400,
                        'http://localhost:8000/${imgUrl}',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          //width: double.infinity,
                          width: 600,
                          child: ElevatedButton(
                            onPressed: () {},
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
                              child: Column(
                                children: [
                                  Text(
                                    ' Empresa : ${priceList?[index].enterprise} \nPreço : R\$:${priceList?[index].price} \nMedida : ${priceList?[index].weigth} ${priceList?[index].un} \nMarca : ${priceList?[index].mark}',
                                  ),
                                ],
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
